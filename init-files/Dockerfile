FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release zip curl gnupg \
   software-properties-common vim default-jre awscli docker-ce-cli jq \
   python3-pip python3-venv python3.11-venv&& apt-get clean
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN groupadd -g 992 docker && usermod -aG docker jenkins
COPY install-aws-tools.sh /var/jenkins_home/install/
RUN chown -R jenkins:jenkins /var/jenkins_home
WORKDIR /var/jenkins_home

USER jenkins
WORKDIR /var/jenkins_home/install
RUN ./install-aws-tools.sh
RUN jenkins-plugin-cli --plugins \
"blueocean configuration-as-code docker-workflow embeddable-build-status git-parameter \
golang pipeline-stage-view purge-job-history timestamper ws-cleanup"
WORKDIR /var/jenkins_home