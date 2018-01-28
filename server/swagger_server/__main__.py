#!/usr/bin/env python3
import os
import sys
lib_path = os.path.abspath(os.path.join(os.path.dirname(__file__), 'database/'))
sys.path.append(lib_path)

import connexion
from .encoder import JSONEncoder
import database


if __name__ == '__main__':
    app = connexion.App(__name__, specification_dir='./swagger/')
    app.app.json_encoder = JSONEncoder
    app.add_api('swagger.yaml', arguments={'title': 'API to support the mobile application steps2save'})
    app.run(port=8080)
