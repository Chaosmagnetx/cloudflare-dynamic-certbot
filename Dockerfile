FROM python:3.8-alpine
LABEL maintainer="Oshayr <Oshayr@Oshayr.com>"
LABEL Name="Dockerized Cloudflare Certbot and Dynamic DNS Updater"
LABEL Version="09.03.21"
VOLUME /etc/letsencrypt
RUN apk update && apk add --no-cache --virtual .build-deps gcc libffi-dev openssl-dev musl-dev python3-dev cargo && \
    pip install --no-cache-dir -U pip certbot certbot-dns-cloudflare cloudflare-ddns && \
    apk del .build-deps && rm -rf /var/cache/apk/* && rm -rf /tmp/* && \
    chmod 600 cloudflare.ini>>cloudflare.ini && \
    echo -e '*/15 * * * * cloudflare-ddns -p $email $api $domain\n0 0 * * * certbot renew\n' > crons && crontab crons && rm crons
CMD if [ -z "$email" ] || [ -z "$api" ] || [ -z "$domain" ]; then echo 'Variable email, domain and api must be specified. Exiting.'; exit 1; fi && \
    echo -e "dns_cloudflare_email = $email\ndns_cloudflare_api_key = $api" > cloudflare.ini && \
    certbot certonly --dns-cloudflare --dns-cloudflare-credentials cloudflare.ini -d ${domain#*.},*.${domain#*.} --agree-tos --email $email -n --expand && \
    certbot certificates && cloudflare-ddns -p $email $api $domain && crond  -f -l 0

