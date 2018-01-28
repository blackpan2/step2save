#!/usr/bin/env python3
import os
import sys
import connexion
from .encoder import JSONEncoder
from .util import deserialize_date, deserialize_datetime

lib_path = os.path.abspath(os.path.join(os.path.dirname(__file__), 'database/'))
sys.path.append(lib_path)
lib_path = os.path.abspath(os.path.join(os.path.dirname(__file__), 'controllers/'))
sys.path.append(lib_path)

import default_controller

if __name__ == '__main__':
    app = connexion.App(__name__, specification_dir='./swagger/')
    app.app.json_encoder = JSONEncoder
    app.add_api('swagger.yaml', arguments={'title': 'API to support the mobile application steps2save'})
    default_controller.add_get('1', 'Thumann Bbq Chicken', "230892")
    default_controller.add_get('1', 'Celeste Pepperoni Pizza', "369215")
    default_controller.add_get('1', 'Wegmans Hard Cider', "39210")
    default_controller.add_get('1', 'GG Cut Green Beans', "587541")
    app.run(port=8080)
