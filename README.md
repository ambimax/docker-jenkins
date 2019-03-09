
# Docker Jenkins

[![Build Status](https://travis-ci.org/ambimax/docker-jenkins.svg?branch=master)](https://travis-ci.org/ambimax/docker-jenkins)


Build custom jenkins image for deployment pipeline

### Login

#### Github oAuth
Default login is github oauth. Please specify required environment variables:

```
GITHUB_OAUTH_CLIENT_ID=123456789
GITHUB_OAUTH_CLIENT_SECRET=123456789123456789
GITHUB_OAUTH_SCOPES="read:org,user:email"
GITHUB_OAUTH_ADMIN_USER="userhandle"
GITHUB_OAUTH_ORGANIZATIONS="company"
GITHUB_OAUTH_USER_READ_PERMISSION=true
GITHUB_OAUTH_USER_CREATE_JOB_PERMISSION=true
GITHUB_OAUTH_ALLOW_GITHUB_WEBHOOK=true
```

#### Normal login

This is not enabled by default. Please uncomment in Dockerfile.
Default login user `admin` with password `3yApzvqwAcs56Y2d`. 

### Plugins

- blueocean
- greenballs
- git
- github-oauth
- github
- slack

### Start

```
docker run -d --env-file ./.env -p 127.0.0.1:8080:8080 -p 127.0.0.1:50000:50000 --name jenkins ambimax/jenkins
```

## License

[MIT License](http://choosealicense.com/licenses/mit/)

## Author Information

 - [Tobias Schifftner](https://twitter.com/tschifftner), [ambimax® GmbH](https://www.ambimax.de)