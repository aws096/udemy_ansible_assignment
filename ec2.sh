#!/bin/bash

terminate() {
    echo "Terminating EC2 instances"
    ansible-playbook -i inventories/ec2.py playbook.ec2-terminate.yml
}
start() {
    echo "Starting EC2 instances"
    ansible-playbook -i inventories/ec2.py playbook.ec2-start.yml
}
deploy() {
    echo "Deploying webapp"
    ansible-playbook -i inventories/ec2.py playbook.yml --private-key=MyEC2KeyPair.pem -u ec2-user

}
case "$1" in
    terminate)
        terminate
        ;;
    start)
        start
        ;;
    deploy)
        deploy
        ;;
    *)
        echo "Usage: ./$(basename "$0") {terminate|start|deploy}"
        exit 1
        ;;
esac
