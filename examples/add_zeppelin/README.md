To add zeppelin to any multi-container environment, add the following information:

To `docker-compose.yaml`:

  zeppelin:
    image: apache/zeppelin:${ZEPPTAG}
    #container_name: zeppelin
    depends_on:
      - backend-1
    networks:
      - backend
    ports:
      - 10002:8080

To the `start_***.sh` at the top with the other exported variables:

export ZEPPTAG=0.9.0

and after the last line in `start_***.sh`:

# Wait until stargate is up before bringing up zeppelin

echo ""
echo "Waiting for stargate to start up..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8082/health)" != "200" ]]; do
    printf '.'
    sleep 5
done

# Bring up zeppelin

docker-compose up -d zeppelin
