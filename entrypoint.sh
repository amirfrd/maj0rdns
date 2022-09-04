#!/bin/sh

echo "Configure iptables..." && \
    iptables -A INPUT --source ${ALLOWED_IP} --jump ACCEPT && \
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED --jump ACCEPT && \
    iptables -P INPUT DROP && \
    iptables -S && \
    echo "Configure dnsmasq..." && \
    sed "s/{IP}/${IP}/" /etc/dnsmasq.tpl > /etc/dnsmasq.conf && \
    echo "Run sniproxy and dnsmasq..." && \
    dnsmasq -khR & sniproxy -c /etc/sniproxy.conf -f