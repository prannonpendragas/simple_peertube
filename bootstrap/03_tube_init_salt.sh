#!/bin/bash
### FUNCTIONS
cd "${0%/*}"
source ./tube_functions

### UPDATE REMOTES
  echo_red "UPDATE REMOTES"
  salt-run cache.clear_git_lock gitfs type=update
  salt-run fileserver.update backend=gitfs

### DEPLOY SIMPLE PEERTUBE
  echo_red "SET UP DEFAULT ENVIRONMENT"
  time salt-run state.orch orch.update_data --state-output=mixed --log-level=quiet # update data
  echo_blue "Generate and deploy PKI"
  time salt-run state.orch orch.generate_pki --state-output=mixed --log-level=quiet
  echo_blue "Install default environment, and apply iptables rules"
  time salt-run state.orch orch.apply_default_env --state-output=mixed --log-level=quiet

  minion_wait

  echo_red "DEPLOY SIMPLE PEERTUBE"
  echo_blue "Install DNS"
  time salt-run state.orch orch.install_dns --state-output=mixed --log-level=quiet
  time salt-run state.orch orch.update_data --state-output=mixed --log-level=quiet # update data

  echo_blue "Install OpenLDAP"
  time salt-run state.orch orch.install_openldap --state-output=mixed --log-level=quiet

  echo_blue "Install PostgreSQL"
  time salt-run state.orch orch.install_postgresql --state-output=mixed --log-level=quiet

  echo_blue "Install Rundeck"
  time salt-run state.orch orch.install_rundeck --state-output=mixed --log-level=quiet


### FINAL SETUP
  echo_red "FINAL SETUP"
  time salt-run state.orch orch.update_data --state-output=mixed --log-level=quiet # update data
  time salt-run state.orch orch.highstate --state-output=mixed --log-level=quiet

# Don't exit until all salt minions are answering
  minion_wait
  echo_blue "All minions are now responding. You may run salt commands against them now"
