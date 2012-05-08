
class vserver::jenkins {

    include ant
    include sudo

    class jenkins {
      jenkins::plugin {
        analysis-core: ;
        analysis-collector: ;
        github: ;
        puppet: ;
        mantis: ;
        php: ;
      }
    }

}
