FROM jenkins/jenkins:lts

LABEL maintainer="Tobias Schifftner <ts@ambimax.de>"

# Use `echo $(stat -c '%g' /var/run/docker.sock)` to find out
ARG HOST_DOCKER_GROUP_ID=1200

# Setting up environment variables for Jenkins admin user
ENV JENKINS_USER admin
ENV JENKINS_PASS 3yApzvqwAcs56Y2d

# Skip the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y sudo libltdl-dev ssh rsync \
  && rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Fixes socket permissions within build containers
RUN groupadd -for -g ${HOST_DOCKER_GROUP_ID} docker
RUN usermod -aG docker jenkins

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Start-up scripts to set number of executors and creating the admin user
COPY scripts/executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY scripts/default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home