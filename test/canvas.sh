#!/usr/bin/env bash
SCRIPT_PATH="$(
  cd "$(dirname "$0")" || exit
  pwd -P
)"

ACTION=${1:-"template"}
K8S_NAMESPACE=${2:-"org-2-tkt-1"}

if [ $ACTION == "template" ]; then
  helm template -n "$K8S_NAMESPACE" -f "$SCRIPT_PATH"/canvas.json tkt-1-canvas "$SCRIPT_PATH"/../src/canvas --output-dir "$SCRIPT_PATH"/.yaml/canvas
elif [ $ACTION == "install" ]; then
  kubectl create namespace "$K8S_NAMESPACE"
  helm install -n "$K8S_NAMESPACE" -f "$SCRIPT_PATH"/canvas.json tkt-1-canvas "$SCRIPT_PATH"/../src/canvas
elif [ $ACTION == "delete" ]; then
  kubectl delete namespace "$K8S_NAMESPACE"
else
  echo "Invalid action"
  exit 1
fi
