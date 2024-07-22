FROM jenkins/jenkins:lts-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release zip curl gnupg \
   software-properties-common vim default-jre awscli jq \
   python3-pip python3-venv python3.11-venv \
   amazon-ecr-credential-helper && apt-get clean
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli && apt-get clean
RUN groupadd -f -g 992 docker && usermod -aG docker jenkins
RUN chown -R jenkins:jenkins /var/jenkins_home
WORKDIR /var/jenkins_home

USER jenkins
RUN jenkins-plugin-cli --plugins \
"aws-credentials blueocean configuration-as-code docker-workflow embeddable-build-status \
git-parameter golang pipeline-stage-view purge-job-history timestamper ws-cleanup"
RUN mkdir -p /var/jenkins_home/.docker
RUN echo '{ "credsStore": "ecr-login" }' > /var/jenkins_home/.docker/config.json