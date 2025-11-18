import os

from flask import Flask, render_template, request, redirect, url_for
import psycopg2

app = Flask(__name__)

def get_db_conn():
    return psycopg2.connect(
        host=os.environ.get('DB_HOST') or 'localhost',
        user=os.environ.get('DB_USER') or 'postgres',
        password=os.environ.get('DB_PASSWORD') or 'password',
        database=os.environ.get('DB_NAME') or 'postgres',
    )

conn = get_db_conn()
cur = conn.cursor()
cur.execute("""
    CREATE TABLE IF NOT EXISTS tasks (
        id SERIAL PRIMARY KEY,
        title VARCHAR NOT NULL,
        done BOOLEAN NOT NULL DEFAULT false
    );
""")
conn.commit()
cur.close()
conn.close()

@app.route('/', methods=['GET'])
def index():
    conn = get_db_conn()
    cur = conn.cursor()
    cur.execute("SELECT * FROM tasks")
    tasks = cur.fetchall()
    cur.close()
    conn.close()

    return render_template('index.html', tasks=[{'id': task[0], 'title': task[1], 'done': task[2]} for task in tasks])


@app.route('/add', methods=['POST'])
def add_task():
    title = request.form.get('title', '').strip()
    if title:
        conn = get_db_conn()
        cur = conn.cursor()
        cur.execute("INSERT INTO tasks (title) VALUES (%s)", (title,))
        conn.commit()
        cur.close()
        conn.close()

    return redirect(url_for('index'))


@app.route('/toggle/<int:task_id>', methods=['POST'])
def toggle_task(task_id):
    conn = get_db_conn()
    cur = conn.cursor()
    cur.execute("UPDATE tasks SET done = NOT done WHERE id = %s", (task_id,))
    conn.commit()
    cur.close()
    conn.close()

    return redirect(url_for('index'))


@app.route('/delete/<int:task_id>', methods=['POST'])
def delete_task(task_id):
    conn = get_db_conn()
    cur = conn.cursor()
    cur.execute("DELETE FROM tasks WHERE id = %s", (task_id,))
    conn.commit()
    cur.close()
    conn.close()

    return redirect(url_for('index'))


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
