CONFIG_BUCKET=storage-cicdpipeline-116815dy3bgkm
CONFIG_BUCKET_PREFIX=init-files

deploy:
	aws cloudformation deploy --template-file jenkins-cheap.yml --stack-name jenkins-cheap --capabilities CAPABILITY_NAMED_IAM

deploy-ha:
	aws cloudformation deploy --template-file jenkins-ha.yml --stack-name jenkins-ha --capabilities CAPABILITY_NAMED_IAM

delete:
	aws cloudformation delete-stack --stack-name jenkins-cheap

delete-ha:
	aws cloudformation delete-stack --stack-name jenkins-ha

val:
	sam validate --lint -t jenkins-cheap.yml

val-ha:
	sam validate --lint -t jenkins-ha.yml

ssh:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-35-172-138-141.compute-1.amazonaws.com

updateinit:
	gtar -zcvf init.tgz init-files
	aws s3 cp init.tgz s3://$(CONFIG_BUCKET)/${CONFIG_BUCKET_PREFIX}/
	rm -f init.tgz
