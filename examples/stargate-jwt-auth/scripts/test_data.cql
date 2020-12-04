CREATE ROLE IF NOT EXISTS 'web_user' WITH PASSWORD = 'web_user' AND LOGIN = TRUE;

CREATE KEYSPACE IF NOT EXISTS food WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':'1'};

CREATE TABLE IF NOT EXISTS food.ingredient (userid text PRIMARY KEY, name text);

INSERT INTO food.ingredient(userid, name) VALUES ('9876', 'celery');
INSERT INTO food.ingredient(userid, name) VALUES ('9876', 'onion');

GRANT MODIFY ON TABLE food.ingredient TO web_user;
GRANT SELECT ON TABLE food.ingredient TO web_user;
