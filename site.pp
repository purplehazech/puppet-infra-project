import "modules/*/manifests/*.pp"

schedule { 'daily':
    period => daily,
    repeat => 1;
}
