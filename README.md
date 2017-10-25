# Ansible Assignment

This is the solution for ansible assignment from Ansible Advanced course.
  This solution contains:
  - AWS EC2 instances for webservers and database
  - AWS Elastic Load Balancer for webservers
  - simple web application using [Python Flask](http://flask.pocoo.org/)
  - [MySQL](https://www.mysql.com/) database


  Below are the steps required to get this working.

  - Prerequisities
  - Configuration
  - Install and Configure Database
  - Start Database Service
  - Install and Configure Web Server
  - Start Web Server

## 0. AWS Prerequisities
  
  - AWS security group with allowed traffic on ports
    - 80 - HTTP for ELB
    - 22 - SSH for Ansible
    - 3306 - MySql for webservers
    - 5000 - Flask webapp for ELB
  - AWS keypair for launching EC2 instances

## 1. Configuration

  Rename aws.conf.example to aws.conf and edit the file:

  - provide full path to vars/ec2.ini file in EC2_INI_PATH property
  - use your credentials in AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY properties
  - provide your amazon login url in EC2_URL property
  - copy your AWS .pem key file to the root folder of the project and provide the key file name in AWS_KEY_NAME property
  
  Rename mail.yml.example to mail.yml and edit the file:

  - your gmail account name in gmail_username variable
  - your gmail password in gmail_password variable (or application password if you are using 2-factor authentication)
  - to whom should be the email sent in mail_send_to variable

  Edit variables in vars files according to your needs:
  - common.yml
  - database.yml
  - ec2.ini
  - elb.yml
  - mail.yml
  - webserver1.yml
  - webserver2.yml

## 2. Start EC2 instances

    ./ec2.sh start

## 3. Deploy webapp, database and ELB

    ./ec2.sh deploy

## 4. Test

Open a browser and go to URL

    http://<ELB_DNS_NAME>                            => Welcome
    http://<ELB_DNS_NAME>/how%20are%20you            => I am good, how about you?
    http://<ELB_DNS_NAME>/read%20from%20database     => JOHN
    
## 5. Cleanup everything

    ./ec2.sh cleanup
