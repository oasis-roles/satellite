library('oasis-pipeline')

oasisMultistreamMoleculePipeline {
  upstream_git_url = 'https://github.com/oasis-roles/satellite.git'
  molecule_role_name = 'satellite'
  molecule_scenarios = ['basic_subscription', 'sub_unsub', 'release_set_unset']
  properties = [pipelineTriggers([cron('H H * * *')])]
}
