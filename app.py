import os

from flask import Flask

app = Flask('example')


@app.route('/')
def health():
    return 'Healthy'


@app.route('/secret')
def secret():
    return os.getenv('SECRET', 'a cake is real')


if __name__ == '__main__':
    app.run(host='0.0.0.0')
