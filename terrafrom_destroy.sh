#!/bin/bash
#-----------------------------------------------------------------------------
# Unpublished Work. All rights Reserved.
# SCRIPT:	terraform_destroy.sh
#
# PURPOSE:	The script executes TERRAFORM DESTROY. It will drop all [PROJECT_NAME] AWS objects created by 
#           010_create_aws_instance role
#
# Parameter: 1)	PROJECT_NAME - name of the project, should reflected project name kept in the workspace
#            2) AUTO_APPROVE flag - automatic deletion without asking
#
# USAGE: ./terraform_destroy <PROJECT_NAME> [-auto-approve]
#
#
# HISTORY:
# Ver.  Date       Author        Comment
#-----------------------------------------------------------------------------
# 1.0   13/08/2022 MLZ     		Initial version
#-----------------------------------------------------------------------------
#
#

Help()
{
    echo "Unpublished Work. All rights Reserved."
    echo "SCRIPT: terraform_destroy.sh"
    echo ""
    echo "PURPOSE: The script executes TERRAFORM DESTROY. It will drop all [PROJECT_NAME] AWS objects created by"
    echo "         20_provision_aws_resources role"
    echo ""
    echo "Parameter: 1) [-auto-approve] flag - automatic deletion without asking"
    echo ""
    echo "USAGE: ./terraform_destroy <PROJECT_NAME> [-auto-approve]"
    echo ""
    echo ""
}

Check_project()
{
    if [[ ! -d "./workspace/$1" ]]; then
        echo "Project $1 does not exists in the workspace!"
        exit 1
    fi
}

if [[ "$1" == "-h" ]]; then
    Help
    exit 0
fi

PROJECT_NAME=$1

if [[ "$#" == 0 ]]; then
    echo "Number of arguments: $#"
    echo "Please provide arguments."
elif [[ "$#" == 1 ]]; then
    Check_project ${PROJECT_NAME}
    terraform -chdir="./workspace/${PROJECT_NAME}" destroy
elif [[ "$#" == 2 ]]; then
    Check_project ${PROJECT_NAME}
    if [[ "$2" == "-auto-approve" ]]; then
        terraform -chdir="./workspace/${PROJECT_NAME}" destroy $2
    else
        echo "The second parameter provided: $2 is not correct."
        echo "Provide optional -auto-approve"
        echo 1
    fi
elif [[ "$#" -gt 2 ]]; then
    echo "To many arguments: $#"
    echo "Check help ./terraform_destroy.sh -h"
fi



