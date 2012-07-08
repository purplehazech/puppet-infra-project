# Class: wc 
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
    $branch = 'master',
    $ensure = exists,
) {
    exec {
        "${name}-git-workingcopy":
            command => "rm -r ${name} && git clone -b ${branch} ${repo} ${name}",
            creates => "$name";

        "${name}-git-remoteorigin":
            command  => "cd ${name} && git remote add origin $repo",
            requires => Exec["${name}-git-workingcopy"]
            creates  => "${name}/.git/refs/remotes/origin";

        "${name}-git-latest":
            command  => "cd ${name} && git pull origin ${branch}",
            requires => Exec["${name}-git-remoteorigin",
            onlyif   => $ensure == latest;
    }
}
