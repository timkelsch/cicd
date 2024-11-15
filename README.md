# cicd

This repo provides the CI/CD pipeline for the mfl-scoring web application.

## Steps to Resume After Shutdown:

1. Ensure AWS access key is configured in your local environment. Check the .envrc DirEnv file.
1. $ make deploy-ha

### If you upgraded Jenkins:

1. Get the admin password from the Jenkins logs. On the EC2 instance: $ docker container logs jenkins-mfl
1. Login to https://jenkins.timkelsch.com. User: admin
1. Create a new admin user, check that it works, and remove the admin user
1. Set up Git and Go in Manage Jenkins | Tools
1. Dashboard | + New Item | Pipeline | Name = mfl-scoring | Save
1. Configure Pipeline | Check "GitHub Project" and Set "Project URL" = https://github.com/timkelsch/mfl-scoring
1. Configure Pipeline | Check "GitHub hook trigger for GITScm polling"
1. Configure Pipeline | Pipeline
   a. Definition = Pipeline Script from SCM
   a. SCM = Git
   a. Repositories | Repository URL = https://github.com/timkelsch/mfl-scoring.git
   a. Repositories | Branches to Build = \*/\*
1. Manually trigger the pipeline

### If you're not upgrading:

1. Get the name of the latest backup in s3://storage-cicdpipeline-\*/jenkins/backups/
1. SSH to the EC2 instance
1. $ cd /var/jenkins_home/backup && ./restore.sh <filename>

#### Tasks:

1. Add a pipeline stage to update prod lambda alias once the PR is merged
1. Automate pull of public IP to Makefile make ssh
1. [x] Enable VPC flow logs to CloudWatch
1. [x] Enable ALB access logs to S3
1. [x] Scoped ECR IAM perms down from \*
1. [x] Increase web server session timeout to 120 minutes
1. [x] Upgrade to Jenkins 2.479.1
