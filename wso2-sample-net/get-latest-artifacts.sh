#!/bin/sh
set -eu

LOGIN="dmytro.lukyanov:Welcome1"
ENV="test"

artifact(){
	local PRJ=${1}
	local ART=${2}
	local DST=${3}
	local ARTNAME=$(basename "$ART")
	local URL="http://teamcity-${ENV}.kernel.local:81/repository/download/${PRJ}/.lastSuccessful/${ART}"
	echo "download ${URL}"
	echo "      to $DST/$ARTNAME"
	mkdir -p $DST
	curl -u "${LOGIN}" "${URL}" > $DST/$ARTNAME
}

## BPS
artifact "id2TestEnvironment_71BuildBpmnProject"                  "Artifats/projects/BPS/KernelPlanningProcess.jar"                      "./deploy/wso2bps/repository/components/lib"
artifact "id2TestEnvironment_71BuildBpmnProject"                  "Artifats/projects/BPS/KernelPlanningProcess.bar"                      "./deploy/wso2bps/repository/deployment/server/bpmn"

## ESB
artifact "id2TestEnvironment_51BuildEsbProject"                   "Artifats/projects/ESB/kernel-esb-config-capp_1.0.0.car"               "./deploy/wso2esb/repository/deployment/server/carbonapps"

## IDS
artifact "id2TestEnvironment_61BuildWso2IdSProjects"             "Artifats/projects/AuthenticationEndpoint/authenticationendpoint.war"  "./deploy/wso2ids/repository/deployment/server/webapps"
