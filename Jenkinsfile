library('oasis-pipeline')

oasisMultistreamMoleculePipeline {
  upstream_git_url = 'https://github.com/oasis-roles/satellite.git'
  molecule_role_name = 'satellite'
  molecule_scenarios = ['default', 'compute']
  properties = [pipelineTriggers([cron('H H * * *')])]
}
