#!groovy

import jenkins.security.s2m.AdminWhitelistRule
import jenkins.model.Jenkins

// Disable CLI over Remoting
jenkins.model.Jenkins.instance.getDescriptor("jenkins.CLI").get().setEnabled(false)

// Enabling the access control mechanism
Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)