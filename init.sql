DROP TABLE IF EXISTS InfoSite;
DROP TABLE IF EXISTS Domain;
CREATE TABLE Domain (id INTEGER PRIMARY KEY, name_domain VARCHAR);
CREATE TABLE InfoSite (
  id INTEGER ,
  url VARCHAR,
  title VARCHAR,
  description VARCHAR,
  keywords VARCHAR,
  date_of_operation VARCHAR,
  FOREIGN KEY(id) REFERENCES Domain(id)
);
INSERT INTO Domain (name_domain) VALUES ('https://google.com'), ('https://yandex.ru/'), ('https://www.yahoo.com/');
