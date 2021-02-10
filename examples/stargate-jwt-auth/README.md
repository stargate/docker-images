This directory includes an example to start a keycloak server along with a Cassandra cluster and a Stargate node.

Documentation on this feature can be found at: [Auth API](https://stargate.io/docs/stargate/0.1/developers-guide/authnz.html).

# Run demo

Use the `start_jwt.sh` shell script to run `docker-compose.yml` to start all the services, along with a `docker run` command
to insert some CQL data for use with the example.
```bash
./start_jwt.sh
```

The `stargate-realm.json` file is used by the keycloak service. 

The CQL files in the `scripts` directory are mounted and run using a docker-cqlsh image.
The `cqlshrc` file gives the docker-cqlsh image user permissions to insert the data.

# Additional information on what the CQL script does:

## Create some data

### Create a role in Cassandra

```cql
CREATE ROLE IF NOT EXISTS 'web_user' WITH PASSWORD = 'web_user' AND LOGIN = TRUE;
```

### Insert some data into Cassandra

```cql
CREATE KEYSPACE IF NOT EXISTS store WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':'1'};

CREATE TABLE IF NOT EXISTS store.shopping_cart (userid text PRIMARY KEY, item_count int, last_update_timestamp timestamp);

INSERT INTO store.shopping_cart (userid, item_count, last_update_timestamp) VALUES ('9876', 2, toTimeStamp(toDate(now())));
INSERT INTO store.shopping_cart (userid, item_count, last_update_timestamp) VALUES ('1234', 5, toTimeStamp(toDate(now())));
```

### Grant role permissions to the table

```cql
CREATE ROLE IF NOT EXISTS 'web_user' WITH PASSWORD = 'web_user' AND LOGIN = TRUE;
GRANT MODIFY ON TABLE store.shopping_cart TO web_user;
GRANT SELECT ON TABLE store.shopping_cart TO web_user;
```
