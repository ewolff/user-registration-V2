# setup jenkins
class { 'jenkins' :
  install_java => false,
  config_hash  => {
    'HTTP_PORT' => { 'value' => '9191' }
  }
}

# install a bunch of useful plugins
$plugins = [
  '::credentials',
  'ssh-credentials',
  'git-client',
  'scm-api',
  'git',
  'jquery',
  'jobConfigHistory',
  'parameterized-trigger',
  'build-pipeline-plugin',
  'disk-usage',
  'monitoring',
  'ws-cleanup',
  'envinject',
  'sonar',
  'clone-workspace-scm',
  'scm-sync-configuration',
  'job-dsl'
]

jenkins::plugin { $plugins : }

# install git package
package { 'git' :
  ensure => installed,
}
