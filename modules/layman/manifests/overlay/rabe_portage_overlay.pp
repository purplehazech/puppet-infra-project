# == Class: layman::overlay::rabe_portage_overlay
#
class layman::overlay::rabe_portage_overlay {
  include layman

  layman::overlay { 'rabe-portage-overlay':
  }

}