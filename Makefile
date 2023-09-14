
deploy:
	aws cloudformation deploy --template-file jenkins.yml --stack-name jenkins --capabilities CAPABILITY_NAMED_IAM

validate:
	sam validate --lint -t jenkins.yml

ssh:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-52-90-143-113.compute-1.amazonaws.com
