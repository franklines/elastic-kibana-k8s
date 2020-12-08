#!/bin/bash

set -u 

function deleteAll()
{
    kubectl delete service elasticsearch;
    kubectl delete service kibana;
    kubectl delete deployment elasticsearch-deployment;
    kubectl delete deployment kibana-deployment;
    kubectl delete configmap kibana-configmap;
    kubectl delete configmap elasticsearch-configmap;
}

function deployAll()
{
    for cm in `ls configmaps/`;
    do
        kubectl apply -f configmaps/${cm};
    done

    for dep in `ls deployments/`;
    do
        kubectl apply -f deployments/${dep};
    done

    for svc in `ls services/`;
    do
        kubectl apply -f services/${svc};
    done
}

while getopts "dr" opt; do
  case ${opt} in
    d )
        deployAll
        ;;
    r )
        deleteAll
        ;;
    \? )
        echo "Invalid option: $OPTARG" 1>&2
        ;;
    : )
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        ;;
  esac
done
shift $((OPTIND -1))
