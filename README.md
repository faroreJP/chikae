# About
The TODO management tool on CLI by Elixir

# Usage
## Add Task
```
$ chikae add <name> [--limit <limit>] [--parent <parent>]
```

## Show Task
```
$ chikae list [--parent {<name>|<uuid>} [--recursive] | --directory | --tree] [--uuid] [--verbose] [--all]
```

## Update Task Progress
```
$ chikae start {<name> | <uuid>}
$ chikae finish {<name> | <uuid>}
$ chikae pend {<name> | <uuid>}
```

## Prune Done Task
```
$ chikae prune
```

