import sqlite3
import os

base = os.path.dirname(__file__)
# qbank_trainer folder is a sibling inside the same workspace root
path = os.path.normpath(os.path.join(base, 'qbank_trainer', 'data.db'))
print('cwd', os.getcwd())
print('db path', path)
print('exists', os.path.exists(path))
conn=sqlite3.connect(path)
cur=conn.cursor()
for row in cur.execute("SELECT name, sql FROM sqlite_master WHERE type='table';"):
    print(row)
conn.close()