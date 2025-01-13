測試 Cloudflare Warp Connector in Docker

編譯指令

```
docker build https://github.com/teddy92729/Cloudflare-Warp-Connector-in-Docker.git --tag warp
```

啟動指令

```
docker run --rm -it --cap-add=NET_ADMIN --device=/dev/net/tun --sysctl net.ipv4.ip_forward=1 -e WARP_CONNECTOR_TOKEN="" warp
```
