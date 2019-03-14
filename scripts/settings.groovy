#!groovy

// imports
import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration

// parameters
def jenkinsParameters = [
  email:  			System.getenv('SETTINGS_EMAIL'),
  url:    			System.getenv('SETTINGS_URL'),
  slackToken: 		System.getenv('SETTINGS_SLACK_TOKEN'),
  slackEndpoint: 	System.getenv('SETTINGS_SLACK_ENDPOINT')
]

// get Jenkins location configuration
def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()

// set Jenkins URL
jenkinsLocationConfiguration.setUrl(jenkinsParameters.url)

// set Jenkins admin email address
jenkinsLocationConfiguration.setAdminAddress(jenkinsParameters.email)

// slack
//jenkinsLocationConfiguration.setSlackOutgoingWebhookToken(jenkinsParameters.slackToken)
//jenkinsLocationConfiguration.setSlackOutgoingWebhookToken(jenkinsParameters.slackEndpoint)

// save current Jenkins state to disk
jenkinsLocationConfiguration.save()
