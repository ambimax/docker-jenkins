#!groovy

import jenkins.security.s2m.AdminWhitelistRule
import jenkins.model.Jenkins

// Enabling the access control mechanism
Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)
