FROM nginx

COPY ./certs/danilocatone.com_ssl_certificate.cer /etc/nginx/www.danilocatone.com.cer
COPY ./certs/_.danilocatone.com_private_key.key /etc/nginx/www.danilocatone.com.key

# COPY conf.d/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /etc/nginx/conf.d
# CMD ["envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf"]
