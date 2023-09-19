# reset to the latest emulation image after the raised issue got solved.
# FROM public.ecr.aws/lambda/go:1
FROM public.ecr.aws/lambda/go:latest

RUN yum groupinstall -y development && \
  yum install -d1 -y \
  tar \
  gzip \
  unzip \
  python38 \
  jq \
  git \
  grep \
  curl \
  make \
  rsync \
  gcc-c++ \
  binutils \
  procps \
  libgmp3-dev \
  zlib1g-dev \
  liblzma-dev \
  libxslt-devel \
  libmpc-devel \
  && yum clean all

# Install Go
RUN curl -L https://go.dev/dl/go1.21.1.linux-arm64.tar.gz | tar -zx -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin:/root/go/bin
# Set GOPROXY envvar to avoid using the default proxy.golang.org proxy
ENV GOPROXY=direct

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" 
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm awscliv2.zip 
RUN rm -rf ./aws

# Prepare virtualenv for lambda builders
RUN python3 -m venv --without-pip /usr/local/opt/lambda-builders
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN /usr/local/opt/lambda-builders/bin/python3 get-pip.py
# Install lambda builders in a dedicated Python virtualenv
RUN AWS_LB_VERSION=$(curl -sSL https://raw.githubusercontent.com/aws/aws-sam-cli/v1.97.0/requirements/base.txt | grep aws_lambda_builders | cut -d= -f3) && \
  /usr/local/opt/lambda-builders/bin/pip3 --no-cache-dir install "aws-lambda-builders==$AWS_LB_VERSION"

# Install SAM CLI via PIP
RUN /usr/local/opt/lambda-builders/bin/pip3 --no-cache-dir install --upgrade aws-sam-cli

ENV PATH=$PATH:/usr/local/opt/lambda-builders/bin

ENV LANG=en_US.UTF-8

# Wheel is required by SAM CLI to build libraries like cryptography. It needs to be installed in the system
# Python for it to be picked up during `sam build`
RUN pip3 install wheel

# Compatible with initial base image
ENTRYPOINT []
CMD ["/bin/bash"]