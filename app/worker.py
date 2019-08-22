import sqlite3
import os
import requests
from bs4 import BeautifulSoup
import datetime


class Worker:
    def __init__(self):
        pass

    def do(self):
        self.request()

    def request(self):
        conn = sqlite3.connect(os.environ['DB_PATH'])
        cur = conn.cursor()
        cur.execute("""
        SELECT name_domain FROM Domain
        """)
        rows = cur.fetchall()
        for r in rows:
            site_info = requests.get(r[0])
            soup = BeautifulSoup(site_info.text, features="html.parser")
            url = r[0]
            title = soup.find('title')
            description = soup.find('description')
            keywords = soup.find('keywords')
            now = datetime.datetime.now()
            sql = """
            INSERT INTO InfoSite (url, title, description, keywords, date_of_operation) 
            VALUES (?,?,?,?,?)
            """
            cur.execute(sql, (
                url,
                title.text if title else 'No title',
                description.text if description else 'No description',
                keywords.text if keywords else 'No keywords',
                now
            ))
        conn.commit()
