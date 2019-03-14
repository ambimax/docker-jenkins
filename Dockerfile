FROM jenkins/jenkins:lts

LABEL maintainer="Tobias Schifftner <ts@ambimax.de>"

# Use `echo $(stat -c '%g' /var/run/docker.sock)` to find out
ARG HOST_DOCKER_GROUP_ID=1200

# Setting up environment variables for Jenkins admin user
ENV JENKINS_USER admin
ENV JENKINS_PASS 3yApzvqwAcs56Y2d

# Github OAuth
ENV GITHUB_OAUTH_CLIENT_ID "12345678901234567890"
ENV GITHUB_OAUTH_CLIENT_SECRET "1234567890123456789012345678901234567890"
ENV GITHUB_OAUTH_API_URL "https://api.github.com"
ENV GITHUB_OAUTH_WEB_URL "https://github.com"
ENV GITHUB_OAUTH_SCOPES "read:org"

ENV GITHUB_OAUTH_ADMIN_USER ""
ENV GITHUB_OAUTH_ORGANIZATIONS ""
ENV GITHUB_OAUTH_USE_REPOSITORY_PERMISSION true
ENV GITHUB_OAUTH_USER_READ_PERMISSION false
ENV GITHUB_OAUTH_USER_CREATE_JOB_PERMISSION false
ENV GITHUB_OAUTH_ALLOW_GITHUB_WEBHOOK false

ENV SETTINGS_EMAIL "jenkins@example.com"
ENV SETTINGS_URL "http://jenkins.docker:8080"

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

# Start-up scripts
COPY scripts/csrf.groovy /usr/share/jenkins/ref/init.groovy.d/
#COPY scripts/default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY scripts/executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY scripts/github-oauth.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY scripts/settings.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY scripts/security.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home