import jenkins.model.*
Jenkins.instance.setNumExecutors(System.getenv('SETTINGS_EXECUTORS').toInteger())
