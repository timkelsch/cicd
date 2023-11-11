CONFIG_BUCKET=storage-cicdpipeline-116815dy3bgkm
CONFIG_BUCKET_PREFIX=init-files

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
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-35-173-212-179.compute-1.amazonaws.com

updateinit:
	gtar -zcvf init.tgz init-files
	aws s3 cp init.tgz s3://$(CONFIG_BUCKET)/${CONFIG_BUCKET_PREFIX}/