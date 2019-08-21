import sqlite3
import os
import requests
from bs4 import BeautifulSoup


class Worker:
    def __init__(self):
        pass

    def do(self):
        conn = sqlite3.connect(os.environ['DB_PATH'])
        cur = conn.cursor()
        cur.execute("""
        INSERT INTO InfoSite (id) VALUES (125),(123)
        """)
        conn.commit()
        self.request()

    def initdb(self):
        conn = sqlite3.connect(os.environ['DB_PATH'])
        cur = conn.cursor()
        cur.execute("""
        INSERT INTO Domain (name_domain) 
        VALUES ('https://google.com'), 
        ('https://yandex.ru/'), 
        ('https://www.yahoo.com/')
                """)
        conn.commit()

    def request(self):
        conn = sqlite3.connect(os.environ['DB_PATH'])
        cur = conn.cursor()
        r = requests.get('https://google.com')
        soup = BeautifulSoup(r.text, features="html.parser")
        s = soup.find('title')
        print(s.text)
