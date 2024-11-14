

deploy:
	aws cloudformation deploy --template-file jenkins-cheap.yml --stack-name jenkins-cheap --capabilities CAPABILITY_NAMED_IAM

deploy-ha:
	aws cloudformation deploy --template-file jenkins-ha.yml --stack-name jenkins-ha --capabilities CAPABILITY_NAMED_IAM

deploy-ec2:
	aws cloudformation deploy --template-file ec2.yml --stack-name ec2 --capabilities CAPABILITY_NAMED_IAM

delete-ha:
	aws cloudformation delete-stack --stack-name jenkins-ha

val:
	aws cloudformation validate-template --template-body file://jenkins-cheap.yml

val-ha:
	aws cloudformation validate-template --template-body file://jenkins-ha.yml

val-ec2:
	aws cloudformation validate-template --template-body file://ec2.yml

ssh:
	ssh -i ~/.ssh/v1.pem ec2-user@${EC2_PUBLIC_DNS}

update-init:
	cd utils && ./update-init.sh
