#!groovy

import jenkins.model.Jenkins

// Disable CLI over Remoting
jenkins.model.Jenkins.instance.getDescriptor("jenkins.CLI").get().setEnabled(false)