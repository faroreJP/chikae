# About
The TODO management tool on CLI by Elixir

# Installation
Chikae requires erlang and elixir.

```
$ git clone https://github.com/faroreJP/chikae.git
$ cd chikae
$ mix escript.build
```

# Usage
## Help
```
$ chikae
```

## Add Task
```
$ chikae add <name> [--limit <limit>] [--parent {<parent_name> | <parent_uuid>}]
```

## Show Task
```
$ chikae list [--parent {<name>|<uuid>} [-r | --recursive] | --tree] [-v | --verbose] [-a | --all] [--raw]
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

