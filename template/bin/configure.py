#!/usr/bin/env python3

import os
import sys
from jinja2 import Environment, FileSystemLoader
import yaml
import glob

# Props: https://stackoverflow.com/questions/823196/yaml-merge-in-python
def merge(user, default):
    if isinstance(user,dict) and isinstance(default,dict):
        for k,v in default.items():
            if k not in user:
                user[k] = v
            else:
                user[k] = merge(user[k],v)
    return user

parent_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
targets = yaml.safe_load(open(os.path.join(parent_dir, '../../distributions.yaml')))
global_data = yaml.safe_load(open(os.path.join(parent_dir, '../../globals.yaml')))

if os.path.isfile(os.path.join(parent_dir, 'conf/conf.yaml')):
    local_data = yaml.safe_load(open(os.path.join(parent_dir, 'conf/conf.yaml')))
else:
    local_data = {}

conf_data = merge(local_data, global_data)

env = Environment(loader = FileSystemLoader(os.path.join(parent_dir, 'conf/')), trim_blocks=True, lstrip_blocks=True)
for template_file in glob.glob(os.path.join(parent_dir, 'conf/') + "*.j2"):

    base_filename = os.path.basename(template_file).removesuffix(".j2")
    template = env.get_template(os.path.basename(template_file))

    if conf_data['shared_package']:
        with open(os.path.join(parent_dir, base_filename), 'w') as output_file:
            output_file.write(template.render(conf_data))
    else:
        codename_list = []
        for distro, codenames in targets['distros'].items():
            for codename in codenames:
                    if codename in conf_data['skip_codenames']:
                        continue
                    codename_list.append(codename)

        conf_data['codenames'] = codename_list
        
        if base_filename == "Makefile":
            with open(os.path.join(parent_dir, base_filename), 'w') as output_file:
                output_file.write(template.render(conf_data))
        else:
            for distro, codenames in targets['distros'].items():
                for codename in codenames:
                    if codename in conf_data['skip_codenames']:
                        continue
                    conf_data['distro'] = distro
                    conf_data['codename'] = codename
                    with open(os.path.join(parent_dir, f'{base_filename}.{codename}'), 'w') as output_file:
                        output_file.write(template.render(conf_data))
