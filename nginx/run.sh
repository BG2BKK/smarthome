#!/bin/bash

killall nginx 

/usr/local/openresty/nginx/sbin/nginx -p `pwd` -c conf/nginx.conf
