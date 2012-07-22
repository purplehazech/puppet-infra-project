# Class: git::wc 
# 
# Class for creating and maintaining working copies.
#
# class {
#   git::wc { "/tmp/git-workingcopy":
#     repo => "http://github.com/purplehazech/puppet-infra-project"
#   }
# }
#

define git::wc(
    $repo,
    $branch   = 'master',
    $ensure   = exists,
    $schedule = 'daily',
) {
    exec {
        "${name}-git-workingcopy":
            command => "/usr/bin/git clone -b ${branch} ${repo} ${name}",
            creates => "$name";

        "${name}-git-remoteorigin":
            cwd     => $name,
            command => "/usr/bin/git remote add origin $repo",
            require => Exec["${name}-git-workingcopy"],
            creates => "${name}/.git/refs/remotes/origin";

        "${name}-git-latest":
            schedule => $schedule,
            cwd      => $name,
            command  => "/usr/bin/git pull origin ${branch}",
            require  => Exec["${name}-git-remoteorigin"],
            onlyif   => "/usr/bin/test $ensure = 'latest'";
    }
}
