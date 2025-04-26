# NetKeeper
Ping ip if fail then restart net.

## Usage
- TARGET: the ip want to pin
- INTERVAL: how many minutes to run 

``` shell
docker run -d --name netkeeper --privileged --restart unless-stopped -e TARGET=1.1.1.1 -e INTERVAL=5 janjangao/netkeeper
```
