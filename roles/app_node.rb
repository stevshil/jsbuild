name "app_node"
description "The application server"
run_list "recipe[allnodes]", "recipe[appnode]"
