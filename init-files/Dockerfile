FROM jenkins/jenkins:lts-jdk17
USER root
ENV JENKINS_OPTS="--sessionTimeout=120 --sessionEviction=120"
RUN apt-get update && apt-get install -y apt-utils && apt-get clean
RUN apt-get install -y lsb-release zip curl gnupg \
  software-properties-common vim default-jre awscli jq \
  python3-pip python3-venv python3.11-venv pass \
  amazon-ecr-credential-helper && apt autoremove && apt-get clean
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli && apt-get clean
RUN curl -L -o /usr/local/bin/docker-credential-pass \
  https://github.com/docker/docker-credential-helpers/releases/download/v0.8.0/docker-credential-pass-v0.8.0.linux-arm64
RUN chmod 555 /usr/local/bin/docker-credential-pass
WORKDIR /var/jenkins_home

USER jenkins
RUN jenkins-plugin-cli --plugins aws-credentials blueocean \
  configuration-as-code docker-workflow embeddable-build-status \
  git-parameter golang json-path-api pipeline-stage-view \
  purge-job-history timestamper ws-cleanup
RUN mkdir -p /var/jenkins_home/.docker && ls -al /var/jenkins_home/
RUN echo '{ "credsStore": "ecr-login" }' > /var/jenkins_home/.docker/config.json
