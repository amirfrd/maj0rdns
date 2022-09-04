FROM alpine:latest

RUN apk add --no-cache sniproxy dnsmasq iptables && ln -sf /dev/stdout /var/log/sniproxy/sniproxy.log
COPY dnsmasq.conf /etc/dnsmasq.tpl
COPY sniproxy.conf /etc/sniproxy.conf

EXPOSE 53/udp
EXPOSE 80
EXPOSE 443

#public ip of the container

ENV IP 162.55.10.138
ENV ALLOWED_IP 0.0.0.0/0

WORKDIR /app
COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]