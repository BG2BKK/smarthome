
* mqtt可以进行通配符过滤，因此不论pub端还是sub端，都可以有一个总的路由或者入口，先把消息收发下来，然后再进行事件分发。
	* 在nodemcu上，sub也可以实现通配符接受，比如/bg2bkk/#，收到消息后，lua可以很容易从topic中匹配到topic中的可变部分；
	* nodemcu启动时，以/sub/mac:chipid作为topic，并向/pub/mac:chipid发布消息，用于向消息中心注册；此时远程的broker对topic /sub/#收到改注册信息，获取到mac:chipid，以后就可以对/pub/mac:chipid发布消息
	* 目前所知道的是mqtt sub端与远端有keepalive机制，需要确认

* nodemcu的mqtt断网重连机制需要考虑，当offline的事件发生时可以重连
	* offline事件发生时，会收到offline事件
	* 在事件处理中，可以启动定时器，每分钟启动重连机制，每次重连3次，直到重连成功
	* 注意再次重连的时候，只有connect事件产生，还需要重新sub，这点比较奇怪；但是不管怎么说，只要它的结果是确定和稳定的，我们就能想办法

	* 当mqtt服务不行的时候，可以通过http方式反馈给server；反之当http不行的时候，可以通过mqtt反馈状态；某一个不行或者都不行的时候，查看当前ip是否不存在，不存在的话，启动重连机制

* mqtt在nodemcu上的keepalive机制，目前看来只需要connect一次broker，其他的sub操作都只是数据包，不会再进行连接；它的心跳机制，可以今天用实验方式观察。
	* 实验方式是：nodemcu sub远程broker；每次sub端断开，通过http方式发送到远程nginx；每次broker检测到断开，同样记录下来；sub端每次收到pub消息后，发送http请求到nginx，可以用来确保mqtt连接正常

* mqtt消息顺序和服务质量
	* http://www.blogjava.net/yongboy/archive/2014/02/15/409893.html


