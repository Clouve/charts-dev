#!/usr/bin/env bash
SCRIPT_PATH="$(
  cd "$(dirname "$0")" || exit
  pwd -P
)"

CHART=${1:-"canvas"}
ACTION=${2:-"template"}
K8S_NAMESPACE=${3:-"org-2-tkt-1"}

if [ $ACTION == "template" ]; then
  helm template -n "$K8S_NAMESPACE" -f "$SCRIPT_PATH"/$CHART.json tkt-1-$CHART "$SCRIPT_PATH"/../src/$CHART --output-dir "$SCRIPT_PATH"/.yaml/$CHART
elif [ $ACTION == "install" ]; then
  kubectl create namespace "$K8S_NAMESPACE"
  helm install -n "$K8S_NAMESPACE" -f "$SCRIPT_PATH"/$CHART.json tkt-1-$CHART "$SCRIPT_PATH"/../src/$CHART
elif [ $ACTION == "delete" ]; then
  kubectl delete namespace "$K8S_NAMESPACE"
else
  echo "Invalid action"
  exit 1
fi
