from flask import Flask, render_template, request, redirect, url_for
from markupsafe import escape

app = Flask(__name__)

TASKS = []
NEXT_ID = 1


@app.route('/', methods=['GET'])
def index():
    return render_template('index.html', tasks=TASKS)


@app.route('/add', methods=['POST'])
def add_task():
    global NEXT_ID
    title = request.form.get('title', '').strip()
    if title:
        TASKS.append({'id': NEXT_ID, 'title': escape(title), 'done': False})
        NEXT_ID += 1
    return redirect(url_for('index'))


@app.route('/toggle/<int:task_id>', methods=['POST'])
def toggle_task(task_id):
    for t in TASKS:
        if t['id'] == task_id:
            t['done'] = not t['done']
            break
    return redirect(url_for('index'))


@app.route('/delete/<int:task_id>', methods=['POST'])
def delete_task(task_id):
    global TASKS
    TASKS = [t for t in TASKS if t['id'] != task_id]
    return redirect(url_for('index'))


if __name__ == '__main__':
    app.run(debug=True)
