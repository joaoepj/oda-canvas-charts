# Open Digital Architecture Canvas
## What is this?
This repo will install and configure a fully working [TMForum Open Digital Architecture](https://www.tmforum.org/collaboration/open-digital-architecture-oda-project/) (ODA) compliant canvas for instantiating ODA components.
## Prerequisites
The installation assumes the following:
* There is a pre-existing [Kubernetes](https://kubernetes.io/) (K8s) cluster with an ingress controller configured
* The cluster is managed by [Rancher](https://rancher.com/) (not strictly necessary for the Canvas installation, but used post-installation by components)
* There is a ```kubeconfig``` file available with adequate permissions on the K8s cluster to:
    * Manage namespaces
    * Install [CRDs](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
    * Manage resources in namespaces
* [Helm 3](https://helm.sh/) is available and configured to use the ```kubeconfig```. An example script (```install_helm.sh```) is provided to install Helm.
* For manual installation (the method described in this README), a command shell (```bash``` is preferred) that can call Helm from shell scripts.
* If the canvas is relying on other underlying services (e.g. Service Mesh) then these should be deployed in advance of the canvas itself.
