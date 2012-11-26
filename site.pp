# == Module: __site__
#
# Btw in bootstrap this is where we load all the modules
# this is used to get something to test during automated
# testing/docbuilding. In production it is not used.
import 'modules/*/manifests/*.pp'
