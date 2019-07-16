#!/usr/bin/env python

import argparse
from flask import abort, Flask, request, send_from_directory
import os
import json

app = Flask(__name__)

@app.route('/<path:path>', methods=['POST'])
def handle_post(path):
    print(request.data)
    return "{}"

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Run a server')
    parser.add_argument('--port', default=80, help='port to bind on')

    args = parser.parse_args()
    app.run(host='0.0.0.0', port=args.port)