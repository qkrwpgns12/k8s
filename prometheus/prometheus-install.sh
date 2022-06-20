#!/usr/bin/env bash
helm install prometheus prometheus/prometheus \
--set pushgateway.enabled=false \
--set nodeExporter.tolerations[0].key=node-role.kubernetes.io/master \
--set nodeExporter.tolerations[0].effect=NoSchedule \
--set nodeExporter.tolerations[0].operator=Exists \
--set server.securityContext.runAsGroup=1000 \
--set server.securityContext.runAsUser=1000 \
--set server.persistentVolume.enabled="ture" \
--set server.persistentVolume.existingClaim="prometheus-server" \
--set server.service.type="LoadBalancer" \
--set server.extraFlags[0]="storage.tsdb.no-lockfile" \
-f values.yaml

