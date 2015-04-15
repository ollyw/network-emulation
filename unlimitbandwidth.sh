#!/bin/bash

source ./vars

tc qdisc del dev $in_if root
tc qdisc del dev $out_if root
