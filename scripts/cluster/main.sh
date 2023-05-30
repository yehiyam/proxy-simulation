#!/bin/bash

export SQUID_NOAUTH_IP=$1

source ./prepare-cluster-node.sh
source ./bootstrap-master-node.sh
source ./install-utils.sh
