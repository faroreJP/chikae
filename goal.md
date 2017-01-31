# add
Add new task into task list.  

```
$ chikae add <name> [--limit <limit>] [--parent <parent>]
```

# list
Show tasks in task list.  

```
$ chikae list [--parent {<name>|<uuid>} [--recursive] | --directory | --tree] [--uuid] [--verbose] [--all]
```

```
$ chikae list
[DOING]   TASK-A     2017/02/10 09:00:00
[DONE]    TASK-A-1   <none>
[DOING]   TASK-A-2   2017/02/10 09:00:00
[TODO]    TASK-A-3   <none>
[TODO]    TASK-A-4   <none>
[TODO]    TASK-A-4-1 <none>
[PENDING] TASK-A-4-2 <none>
```

```
$ chikae list --parent TASK-A
[DONE]    TASK-A-1
[DOING]   TASK-A-2
[TODO]    TASK-A-3
[TODO]    TASK-A-4
```

```
$ chikae list --parent TASK-A --recursive
[DONE]    TASK-A-1   
[DOING]   TASK-A-2   
[TODO]    TASK-A-3   
[TODO]    TASK-A-4   
[TODO]    TASK-A-4-1 
[PENDING] TASK-A-4-2 
```

```
$ chikae list --directory
[DOING]   TASK-A                     
[DONE]    TASK-A/TASK-A-1            
[DOING]   TASK-A/TASK-A-2            
[TODO]    TASK-A/TASK-A-3            
[TODO]    TASK-A/TASK-A-4            
[TODO]    TASK-A/TASK-A-4/TASK-A-4-1 
[PENDING] TASK-A/TASK-A-4/TASK-A-4-2 
```

```
$ chikae list --tree
[33%]     v TASK-A
[DONE]      > TASK-A-1     
[DOING]     > TASK-A-2     
[TODO]      > TASK-A-3     
[0%]        v TASK-A-4     
[TODO]        > TASK-A-4-1 
[PENDING]     > TASK-A-4-2 
```

```
$ chikae list --tree --uuid -v
[33%]                              v TASK-A         3s518hs-214f9had-3234adsd-2glsdi
[DONE at 2017/1/17 18:24:22]         > TASK-A-1     135dgad-214f9had-3234adsd-2glsdi
[DOING since 2017/1/19 09:00:00]     > TASK-A-2     135dgad-214f9had-3234adsd-2glsdi
[TODO]                               > TASK-A-3     135dgad-214f9had-3234adsd-2glsdi
[0%]                                 v TASK-A-4     135dgad-214f9had-3234adsd-2glsdi
[TODO]                                 > TASK-A-4-1 01g9sdf-214f9had-3234adsd-2glsdi
[PENDING]                              > TASK-A-4-2 1249dga-214f9had-3234adsd-2glsdi
```

```
$ chikae list --all
[33%]     v TASK-A         3s518hsj
[DONE]      > TASK-A-1     135dgads
[DOING]     > TASK-A-2     135dgads
[TODO]      > TASK-A-3     135dgads
[0%]        v TASK-A-4     135dgads
[TODO]        > TASK-A-4-1 01g9sdfs
[PENDING]     > TASK-A-4-2 1249dgas
[100%]    v *TASK-B        3s518hsj
[DONE]      > *TASK-B-1    135dgads
[DONE]      > *TASK-B-2    135dgads
```

# change state
Use `start` to change task state to DOING.  

```
$ chikae start {<name> | <uuid>}
<name> has been started! [2017/1/29 09:11:12]
```

Use `finish` to change task state to DONE.  

```
$ chikae finish {<name> | <uuid>}
<name> has been finished! [2017/1/29 09:11:12]
```

Use `pend` to change task state to PENDING.  

```
$ chikae pend {<name> | <uuid>}
<name> has been pended! [2017/1/29 09:11:12]
```

# prune
Prune tasks that have state is DONE in task list.  
Pruned tasks are not displayed `list` command unless using `--all` option.  

```
$ chikae prune
pruned 3 task
* TASK-1
* TASK-2
* TASK-3
```

# schedule
Schedule regular task.  

```
$ chikae schedule <name> [--at <date_time>] [--date <date>]
```

# rename
Rename task in task list.  

```
$ chikae rename {<name> | <uuid>} <new_name>
```




