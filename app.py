import os

from flask import Flask

app = Flask('example')


@app.route('/')
def health():
    return 'Healthy'


@app.route('/secret')
def secret():
    return os.getenv('SECRET', 'it didn\'t work')


if __name__ == '__main__':
    app.run(host='0.0.0.0')
