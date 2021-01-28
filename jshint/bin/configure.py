#!/usr/bin/env python3

import os
import sys
from jinja2 import Environment, FileSystemLoader
import yaml

parent_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
targets = yaml.safe_load(open(os.path.join(parent_dir, '../distributions.yaml')))
conf_data = yaml.safe_load(open(os.path.join(parent_dir, 'conf/conf.yaml')))
env = Environment(loader = FileSystemLoader(os.path.join(parent_dir, 'conf/')), trim_blocks=True, lstrip_blocks=True)
template = env.get_template('Dockerfile.j2')

for distro, codenames in targets['distros'].items():
    for codename in codenames:
        conf_data['distro'] = distro
        conf_data['codename'] = codename
        with open(os.path.join(parent_dir, f'Dockerfile.{codename}'), 'w') as dockerfile:
            dockerfile.write(template.render(conf_data))
