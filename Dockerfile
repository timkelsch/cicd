FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release  \
  curl gnupg software-properties-common sudo
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli python3-pip python3-venv python3.11-venv
RUN groupadd docker && usermod -aG docker jenkins
WORKDIR /var/jenkins_home/install
COPY jenkins-plugins.txt .
COPY install-aws-tools.sh .
COPY install-plugins.sh .
RUN chown -R jenkins:jenkins /var/jenkins_home
RUN ./install-aws-tools.sh

USER jenkins
WORKDIR /var/jenkins_home