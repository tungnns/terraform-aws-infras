#!/usr/bin/env python3

import json
import subprocess

def get_terraform_state():
    result = subprocess.run(['terraform', 'show', '-json'], stdout=subprocess.PIPE)
    return json.loads(result.stdout)

def generate_inventory(tfstate):
    inventory = {"_meta": {"hostvars": {}}}
    instances = tfstate['values']['root_module']['resources']
    for instance in instances:
        if instance['type'] == 'aws_instance':
            instance_name = instance['values']['tags']['Name']
            instance_id = instance['values']['id']
            instance_ip = instance['values']['public_ip']
            inventory[instance_name] = {'hosts': [instance_ip]}
            inventory['_meta']['hostvars'][instance_ip] = {
                'ansible_host': instance_ip,
                'instance_id': instance_id
            }
    return inventory

if __name__ == "__main__":
    tfstate = get_terraform_state()
    inventory = generate_inventory(tfstate)
    print(json.dumps(inventory, indent=2))

