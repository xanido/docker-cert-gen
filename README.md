Use this utility to quickly & easily generate TLS certs for your docker
host.

Example usage:

```
docker run --rm \
  -v ~/.docker/certs:/certs/ca:ro \
  -v $(pwd):/certs/out:rw \
  -e SAN="IP:0.0.0.0,DNS:my.domain" \
  xanido/docker-cert-gen
```

Behaviour can be customised with env vars:

| Env name | default |
|----------|---------|
| `CA_CERT_PATH` | `/certs/ca` |
| `CERT_PATH` | `/certs/out` |
| `SAN` | `IP:127.0.0.1,DNS:localhost` |
