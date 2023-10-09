config-bucket = config-figgity-fuggity

deploy:
	aws cloudformation deploy --template-file jenkins-cheap.yml --stack-name jenkins-cheap --capabilities CAPABILITY_NAMED_IAM

deploy-ha:
	aws cloudformation deploy --template-file jenkins-ha.yml --stack-name jenkins-ha --capabilities CAPABILITY_NAMED_IAM

deploy-ec3:
	aws cloudformation deploy --template-file ec3.yml --stack-name ec3 --capabilities CAPABILITY_NAMED_IAM

val:
	sam validate --lint -t jenkins-cheap.yml

val-ha:
	sam validate --lint -t jenkins-ha.yml

val-ec3:
	sam validate --lint -t ec3.yml

ssh:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-54-164-8-79.compute-1.amazonaws.com

sshec3:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-34-229-97-22.compute-1.amazonaws.com

ssh-ha:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-23-22-101-239.compute-1.amazonaws.com

updateinit:
	gtar -zcvf init.tgz init-files
	aws s3 cp init.tgz s3://$(config-bucket)/