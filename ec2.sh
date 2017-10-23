#!/bin/bash

export SOURCE_FOLDER=$(dirname "$0")
cd ${SOURCE_FOLDER}

source aws.conf

cleanup() {
    echo "Terminating EC2 instances and removing ELB"
    ansible-playbook -i inventories/ec2.py playbook.ec2-cleanup.yml
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
    cleanup)
        cleanup
        ;;
    start)
        start
        ;;
    deploy)
        deploy
        ;;
    *)
        echo "Usage: ./$(basename "$0") {cleanup|start|deploy}"
        exit 1
        ;;
esac
