# ADD
```
$ chikae add <name> (--limit <limit> | --parent <parent>)
```

# LIST
```
$ chikae list
TASK-A     [DOING]   3s518hsj
TASK-A-1   [DONE]    135dgads
TASK-A-2   [DOING]   135dgads
TASK-A-3   [TODO]    135dgads
TASK-A-4   [TODO]    135dgads
TASK-A-4-1 [TODO]    01g9sdfs
TASK-A-4-2 [PENDING] 1249dgas
```

```
$ chikae list --tree
v TASK-A         [33%]     3s518hsj
  > TASK-A-1     [DONE]    135dgads
  > TASK-A-2     [DOING]   135dgads
  > TASK-A-3     [TODO]    135dgads
  v TASK-A-4     [0%]      135dgads
    > TASK-A-4-1 [TODO]    01g9sdfs
    > TASK-A-4-2 [PENDING] 1249dgas
```

```
$ chikae list --tree -v
v TASK-A         [33%]                              3s518hs-214f9had-3234adsd-2glsdi
  > TASK-A-1     [DONE at 2017/1/17 18:24:22]       135dgad-214f9had-3234adsd-2glsdi
  > TASK-A-2     [DOING since 2017/1/19 09:00:00]   135dgad-214f9had-3234adsd-2glsdi
  > TASK-A-3     [TODO]                             135dgad-214f9had-3234adsd-2glsdi
  v TASK-A-4     [0%]                               135dgad-214f9had-3234adsd-2glsdi
    > TASK-A-4-1 [TODO]                             01g9sdf-214f9had-3234adsd-2glsdi
    > TASK-A-4-2 [PENDING]                          1249dga-214f9had-3234adsd-2glsdi
```

```
$ chikae list --all
v TASK-A         [33%]     3s518hsj
  > TASK-A-1     [DONE]    135dgads
  > TASK-A-2     [DOING]   135dgads
  > TASK-A-3     [TODO]    135dgads
  v TASK-A-4     [0%]      135dgads
    > TASK-A-4-1 [TODO]    01g9sdfs
    > TASK-A-4-2 [PENDING] 1249dgas
v *TASK-B        [100%]    3s518hsj
  > *TASK-B-1    [DONE]    135dgads
  > *TASK-B-2    [DONE]    135dgads
```

# UPDATE
```
$ chikae start <name>
<name> has been started! [2017/1/29 09:11:12]
```

or  

```
$ chikae finish <name>
<name> has been finished! [2017/1/29 09:11:12]
```
or  

```
$ chikae pend <name>
<name> has been pended! [2017/1/29 09:11:12]
```

# PRUNE
```
$ chikae prune
pruned 3 task
* TASK-1
* TASK-2
* TASK-3
```

# SCHEDULE
```
$ chikae schedule <name> (--at <date_time> | --date <date>)
```
