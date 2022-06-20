#!/usr/bin/env bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install grafana grafana/grafana \
--set service.type=LoadBalancer \
--set securityContext.runAsUser=1000 \
--set securityContext.runAsGroup=1000 \
--set adminPassword="admin"
