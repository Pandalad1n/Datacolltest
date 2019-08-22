DROP TABLE IF EXISTS InfoSite;
DROP TABLE IF EXISTS Domain;
CREATE TABLE InfoSite (id INTEGER PRIMARY KEY, url VARCHAR, title VARCHAR, description VARCHAR, keywords VARCHAR, date_of_operation VARCHAR);
CREATE TABLE Domain (id INTEGER PRIMARY KEY, name_domain VARCHAR);
INSERT INTO Domain (name_domain) VALUES ('https://google.com'), ('https://yandex.ru/'), ('https://www.yahoo.com/');
