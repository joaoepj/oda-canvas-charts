#!/bin/bash

echo ""
echo "*********************************************************************"
echo "Configuring Helm repositories"
echo "*********************************************************************"
echo ""

helm repo add stable https://charts.helm.sh/stable
helm repo add codecentric https://codecentric.github.io/helm-charts
helm repo add incubator https://charts.helm.sh/incubator
helm repo add bitnami https://charts.bitnami.com/bitnami

echo ""
echo "*********************************************************************"
echo "Creating tls certificates"
echo "*********************************************************************"
echo ""

bash ./create_tls_certificates.sh

echo ""
echo "*********************************************************************"
echo "Preparing helm chart external dependencies"
echo "*********************************************************************"
echo ""

# Keycloak relies on the Bitnami PostgreSQL chart
pushd canvas/charts/keycloak/
helm dependency update
popd

echo ""
echo "*********************************************************************"
echo "Installing base canvas"
echo "*********************************************************************"
echo ""

CABUNDLE=$(kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}')

helm install --namespace canvas canvas canvas/ --set global.clusterCABundle=$CABUNDLE
retVal=$?

if [ $retVal -ne 0 ]; then
    echo ""
    echo "Canvas base install failed"
    exit 1
fi

echo ""
echo "*********************************************************************"
echo "Install script finished"
echo "*********************************************************************"
exit 0

