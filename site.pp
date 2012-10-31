# Module: __site__
#
#
module __site__ {
    import "modules/*/manifests/*.pp"

    schedule { 'daily':
        period => daily,
        repeat => 1;
    }
}
