# blue green deployment of infra for seamless upgrades, rollbacks, and H/A infra for users
1. Prod infra configured with application seving for end user (Blue).
2. Another Backup infra configured with exact same as Prod on standby, which can be used for DR, Upgrade deployment, or Rollbacks.
3. If enviornment calls for it , only Loadbalancer enmdpoint can be switched to this envioenment endpoint  for HA infra.
5. If the blue infra host app version 1.0.22 and need to deploy 1.0.23, 
   - then instead of deploying it in same infra provison idential and deploy new app version on new infra and swap dns endpoint.
   - this method gives a back up for version rollbacks, this way old version and new version are both available if required.
   - and also without having to have downtime for application accesiblity for end users.