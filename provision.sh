#!/bin/bash

# This is the provisioning script that will automate the entire build or update

# Help
if [[ "$1" == "help" ]] || (( $# < 1 ))
then
	echo "USAGE: $0 [all|test|deco|host]"
	echo "  Using all will build or provision all 3 hosts"
	echo "  Using test will make a check that the application is responding as expected"
	echo "  Using deco will destroy all of the VMs"
	echo "  Using host will allow you to select either the Web node or the 2 App nodes"
	exit 0
fi

# Get list of running nodes
running=$(vagrant status | grep running | cut -d' ' -f1)
lb="Web node"
ap1="Application Node 1"
ap2="Application Node 2"

function apptest() {
	nodeA=$(curl http://localhost:1080 2>/dev/null | grep appnode | awk '{print $NF}')
	nodeB=$(curl http://localhost:1080 2>/dev/null | grep appnode | awk '{print $NF}')
	if [[ "$nodeA" != "$nodeB" ]]
	then
		echo "Application is running as expected"
		echo "First call was $nodeA and second call $nodeB"
	else
		echo "ERROR: Application is returning the same backend node"
		echo "ERROR: First call was $nodeA and second call $nodeB"
		exit 1
	fi
}

function do_host() {
	host="$1"
	# Check if host is up
	if echo "$running" | grep $host >/dev/null
	then
		eval echo "\$$host already running, performing a provision"
		vagrant provision $host
	else
		eval echo "Starting \$$host and provisioning"
		vagrant up $host
		vagrant provision $host
	fi
}

function select_host() {
	select host in EXIT "Web Node" "Application Servers"
	do
		case $host in
			EXIT)	exit 0
				;;
			Web*)	do_host lb
				;;
			App*)	do_host ap1
				do_host ap2
				;;
			*)	echo "Unknown host or action"
				;;
		esac
	done
}

if [[ "$1" == "all" ]]
then
	for host in ap1 ap2 lb
	do
		if do_host $host
		then
			eval echo "Build for \$$host completed successfully"
		else
			eval echo "Build for \$$host FAILED"
			exit 1
		fi
	done
	sleep 15 # Allow time for application to stabalise
	apptest
elif [[ "$1" == "host" ]]
then
	echo "Select host(s) to provision or start"
	select_host
elif [[ "$1" == "deco" ]]
then
	for host in ap1 ap2 lb
	do
		vagrant destroy $host --force
	done
elif [[ "$1" == "test" ]]
then
	echo "About to test service"
	apptest
fi
