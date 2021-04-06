FROM nginx

RUN rm -f /etc/nginx/conf.d/*
ADD ./containers/nginx/nginx.conf /etc/nginx/conf.d/nayami2.conf
# nginxの起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
