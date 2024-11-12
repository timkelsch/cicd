# cicd

Steps to Resume:
1. Ensure AWS access key is configured
1. $ make deploy-ha
1. Get the name of the latest backup in s3://storage-cicdpipeline-*/jenkins/backups/
1. SSH to the EC2 instance
1. $ cd /var/jenkins_home/backup && ./restore.sh <filename>
