# cicd

## Steps to Resume After Shutdown:

1. Ensure AWS access key is configured
1. $ make deploy-ha
1. Get password from logs: docker container logs jenkins-mfl

### If you are upgrading:

1. Login to https://jenkins.timkelsch.com. User = admin. Pass in container logs.
1. Create admin user
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

#### Completed Tasks:

1. Upgrade to Jenkins 2.479.1
1. Increase web server session timeout to 120 minutes
1. Scoped ECR IAM perms down from \*
1. Enable ALB flow logs

TODO:

1. Automate pull of public IP to make ssh
