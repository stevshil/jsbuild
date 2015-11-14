name "app_node",
description "The load balancing server",
run_list "recipe[allnodes]", "recipe[appnode]"
