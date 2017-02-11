# About
The TODO management tool on CLI by Elixir

# Usage
## Add Task
```
$ chikae add <name> [--limit <limit>] [--parent {<parent_name> | <parent_uuid>}]
```

## Show Task
```
$ chikae list [--parent {<name>|<uuid>} [-r | --recursive] | --tree] [-v | --verbose] [-a | --all]
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

