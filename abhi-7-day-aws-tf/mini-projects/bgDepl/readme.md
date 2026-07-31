# blue green deployment of infra for deamless upgrades, rollbacks, and H/A infra for users
1. Prod infra configured with application seving for end user (Blue).
2. Another Backup infra configured with exact same as Prod on standby, which can be used for DR, Upgrade deployment, or Rollbacks.
3. If enviornment calls for it , only Loadbalancer enmdpoint can be switched to this envioenment endpoint  for HA infra.