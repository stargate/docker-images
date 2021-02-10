#!/bin/bash

USER_TOKEN=$(curl -s --data "username=testuser1&password=testuser1&grant_type=password&client_id=user-service" http://localhost:4444/auth/realms/stargate/protocol/openid-connect/token | jq -r '.access_token')


curl -sL 'localhost:8082/v1/keyspaces/system/tables/local/rows/local' \
-H "X-Cassandra-Token: $USER_TOKEN" | jq .


curl -sL 'localhost:8082/v1/keyspaces/store/tables/shopping_cart/rows/9876' \
-H "X-Cassandra-Token: $USER_TOKEN" | jq .

# Should return:
#{
#  "count": 1,
#  "rows": [
#    {
#      "item_count": 2,
#      "userid": "9876",
#      "last_update_timestamp": "2020-11-06T00:00:00Z"
#    }
#  ]
#}

curl -sL 'localhost:8082/v1/keyspaces/store/tables/shopping_cart/rows/1234' \
-H "X-Cassandra-Token: $USER_TOKEN" | jq .

# Should return:
#{
#  "description": "Role unauthorized for operation: Not allowed to access this resource",
#  "code": 401
#}
