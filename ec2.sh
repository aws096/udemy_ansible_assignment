#!/bin/bash

export SOURCE_FOLDER=$(dirname "$0")
cd ${SOURCE_FOLDER}

source aws.conf

start() {
    echo "Launching EC2 instances"
    ansible-playbook -i inventories/ec2.py playbook.ec2-start.yml
}
deploy() {
    echo "Deploying database, webapp and starting ELB"
    ansible-playbook -i inventories/ec2.py playbook.yml --private-key=$AWS_KEY_NAME -u ec2-user
}
cleanup() {
    echo "Terminating EC2 instances and removing ELB"
    ansible-playbook -i inventories/ec2.py playbook.ec2-cleanup.yml --private-key=$AWS_KEY_NAME -u ec2-user
}

case "$1" in
    start)
        start
    ;;
    deploy)
        deploy
    ;;
    cleanup)
        cleanup
    ;;
    *)
        echo "Usage: ./$(basename "$0") {cleanup|start|deploy}"
        exit 1
    ;;
esac
