#!/bin/bash

ansible-playbook -i inventories playbook.ec2-start.yml --private-key=MyEC2KeyPair.pem -u ec2-user

ansible-playbook -i inventories/ec2.py playbook.yml --private-key=MyEC2KeyPair.pem -u ec2-user