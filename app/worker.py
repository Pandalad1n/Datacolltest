import sqlite3
import os
import requests
from bs4 import BeautifulSoup
from datetime import datetime


class Worker:
    def __init__(self):
        pass

    def do(self):
        print('Worker started')
        self.request()

    def request(self):
        conn = sqlite3.connect('/var/data/sitedb.db')
        cur = conn.cursor()
        cur.execute("""
            SELECT name_domain, id FROM Domain
        """)
        rows = cur.fetchall()
        cur.execute("""
            SELECT id FROM InfoSite
        """)
        existing_ids = [i[0] for i in cur.fetchall()]
        for r in rows:
            site_info = requests.get(r[0])
            soup = BeautifulSoup(site_info.text, features="html.parser")
            url = r[0]
            title = soup.find('title')
            description = soup.find('description')
            keywords = soup.find('keywords')
            now = datetime.now()
            if r[1] not in existing_ids:
                sql = """
                INSERT INTO InfoSite (id, url, title, description, keywords, date_of_operation)
                VALUES ({},?,?,?,?,?)
                """.format(r[1])
                print('Site ' + url + ' added')
            else:
                sql = """
                UPDATE InfoSite 
                SET url = ?, title = ?, description = ?, keywords = ?, date_of_operation = ?
                WHERE id = {}
                """.format(r[1])
                print('Site ' + url + ' updated')
            cur.execute(sql, (
                url,
                title.text if title else 'No title',
                description.text if description else 'No description',
                keywords.text if keywords else 'No keywords',
                now
            ))

        conn.commit()
