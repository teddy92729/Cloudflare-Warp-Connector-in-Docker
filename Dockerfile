FROM ubuntu:24.04 AS warp

RUN set -eux; \
    apt update; \
    apt install -y pgp curl; \
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ noble main" | tee /etc/apt/sources.list.d/cloudflare-client.list; \
    apt update; \
    apt install -y cloudflare-warp

FROM ubuntu:24.04 AS dist

RUN set -eux; \
    apt update; \
    apt install -y dbus libnspr4 libnss3 iptables; \
    apt clean  

COPY --from=warp /bin/warp-cli /bin/warp-cli
COPY --from=warp /bin/warp-svc /bin/warp-svc

RUN set -eux; \
    mkdir -p /var/lib/cloudflare-warp /var/run/dbus;

WORKDIR /var/lib/cloudflare-warp

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/bash" ]
