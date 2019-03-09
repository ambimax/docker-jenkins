#!groovy

import hudson.security.SecurityRealm
import org.jenkinsci.plugins.GithubSecurityRealm
import jenkins.model.Jenkins

String githubWebUri = System.getenv('GITHUB_OAUTH_WEB_URL')
String githubApiUri = System.getenv('GITHUB_OAUTH_API_URL')
String clientID = System.getenv('GITHUB_OAUTH_CLIENT_ID')
String clientSecret = System.getenv('GITHUB_OAUTH_CLIENT_SECRET')
String oauthScopes = System.getenv('GITHUB_OAUTH_SCOPES')

SecurityRealm github_realm = new GithubSecurityRealm(githubWebUri, githubApiUri, clientID, clientSecret, oauthScopes)
//check for equality, no need to modify the runtime if no settings changed
if(!github_realm.equals(Jenkins.instance.getSecurityRealm())) {
    Jenkins.instance.setSecurityRealm(github_realm)
    Jenkins.instance.save()
}

import org.jenkinsci.plugins.GithubAuthorizationStrategy
import hudson.security.AuthorizationStrategy

//permissions are ordered similar to web UI
//Admin User Names
String adminUserNames = System.getenv('GITHUB_OAUTH_ADMIN_USER')
//Participant in Organization
String organizationNames = System.getenv('GITHUB_OAUTH_ORGANIZATIONS')
//Use Github repository permissions
boolean useRepositoryPermissions = System.getenv('GITHUB_OAUTH_USE_REPOSITORY_PERMISSION')
//Grant READ permissions to all Authenticated Users
boolean authenticatedUserReadPermission = System.getenv('GITHUB_OAUTH_USER_READ_PERMISSION')
//Grant CREATE Job permissions to all Authenticated Users
boolean authenticatedUserCreateJobPermission = System.getenv('GITHUB_OAUTH_USER_CREATE_JOB_PERMISSION')
//Grant READ permissions for /github-webhook
boolean allowGithubWebHookPermission = System.getenv('GITHUB_OAUTH_ALLOW_GITHUB_WEBHOOK')
//Grant READ permissions for /cc.xml
boolean allowCcTrayPermission = false
//Grant READ permissions for Anonymous Users
boolean allowAnonymousReadPermission = false
//Grant ViewStatus permissions for Anonymous Users
boolean allowAnonymousJobStatusPermission = false

AuthorizationStrategy github_authorization = new GithubAuthorizationStrategy(
	adminUserNames,
	authenticatedUserReadPermission,
	useRepositoryPermissions,
	authenticatedUserCreateJobPermission,
	organizationNames,
	allowGithubWebHookPermission,
	allowCcTrayPermission,
	allowAnonymousReadPermission,
	allowAnonymousJobStatusPermission
)

//check for equality, no need to modify the runtime if no settings changed
if(!github_authorization.equals(Jenkins.instance.getAuthorizationStrategy())) {
    Jenkins.instance.setAuthorizationStrategy(github_authorization)
    Jenkins.instance.save()
}