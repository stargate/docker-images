To add zeppelin to any multi-container environment, add the following information:

To `docker-compose.yaml`:

```
  zeppelin:
    image: apache/zeppelin:${ZEPPTAG}
    depends_on:
      - backend-1
    networks:
      - backend
    ports:
      - 10002:8080
```

To the `start_***.sh` at the top with the other exported variables:

```
export ZEPPTAG=0.9.0
```

and after the last line in `start_***.sh`:

```
# Bring up zeppelin

docker-compose up -d zeppelin
```
