#!/bin/bash

echo "apiVersion: v1
clusters:
- cluster:
    server: ${{ steps.get-cluster-credentials.outputs.cluster_endpoint }}
    certificate-authority-data: ${{ steps.get-cluster-credentials.outputs.ca_certificate }}
  name: ${{ secrets.CLUSTER_NAME }}
contexts:
- context:
    cluster: ${{ secrets.CLUSTER_NAME }}
    user: my-kubernetes-user
  name: my-kubernetes-context
current-context: my-kubernetes-context
kind: Config
preferences: {}
users:
- name: my-kubernetes-user
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - 'token'
        - '-i'
        - '${{ secrets.CLUSTER_NAME }}'" > kubeconfig.yaml
