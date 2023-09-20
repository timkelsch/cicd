
deploy:
	aws cloudformation deploy --template-file jenkins.yml --stack-name jenkins --capabilities CAPABILITY_NAMED_IAM

dec:
	aws cloudformation deploy --template-file ec2.yml --stack-name ec2 --capabilities CAPABILITY_NAMED_IAM

dec2:
	aws cloudformation deploy --template-file ec3.yml --stack-name ec3 --capabilities CAPABILITY_NAMED_IAM

vec:
	sam validate --lint -t ec2.yml

vec2:
	sam validate --lint -t ec3.yml

validate:
	sam validate --lint -t jenkins.yml

sshec2:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-3-80-72-20.compute-1.amazonaws.com

ssh:
	ssh -i ~/.ssh/v1.pem ec2-user@ec2-52-90-143-113.compute-1.amazonaws.com
