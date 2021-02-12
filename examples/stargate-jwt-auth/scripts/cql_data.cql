// create role for demos
CREATE ROLE IF NOT EXISTS 'web_user' WITH PASSWORD = 'web_user' AND LOGIN = TRUE;

// create REST API example
CREATE KEYSPACE IF NOT EXISTS store WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':'1'};

CREATE TABLE IF NOT EXISTS store.shopping_cart (userid text PRIMARY KEY, item_count int, last_update_timestamp timestamp);

INSERT INTO store.shopping_cart (userid, item_count, last_update_timestamp) VALUES ('9876', 2, toTimeStamp(toDate(now())));
INSERT INTO store.shopping_cart (userid, item_count, last_update_timestamp) VALUES ('1234', 5, toTimeStamp(toDate(now())));

GRANT MODIFY ON TABLE store.shopping_cart TO web_user;
GRANT SELECT ON TABLE store.shopping_cart TO web_user;

// create GraphQL example
CREATE KEYSPACE IF NOT EXISTS library WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':'1'};

CREATE TABLE IF NOT EXISTS library.books (title text PRIMARY KEY, author text);
CREATE TABLE IF NOT EXISTS library.authors (name text PRIMARY KEY, title text);

GRANT MODIFY ON TABLE library.books TO web_user;
GRANT MODIFY ON TABLE library.authors TO web_user;
GRANT SELECT ON TABLE library.books TO web_user;
GRANT SELECT ON TABLE library.authors TO web_user;
