import sqlite3, traceback
try:
    conn = sqlite3.connect('assets/data.db')
    c = conn.cursor()
    c.execute('SELECT name FROM sqlite_master WHERE type="table"')
    print('tables', c.fetchall())
    c.execute('SELECT COUNT(*) FROM questions')
    print('count', c.fetchone())
    c.execute('SELECT q_num, stem_zh, stem_en FROM questions LIMIT 5')
    print('sample', c.fetchall())
except Exception as e:
    print('error', e)
    traceback.print_exc()
