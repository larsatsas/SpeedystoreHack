# Powershell script to find the IP address of the Singlestore DDL endpoint
# Run this from your home folder inside Powershell
# Prerequisites:
# * kubectl installed and available
# * kubeconfig for your environment downloaded and stored at .kube/engagekube
# * Run from your home folder
# Powershell kode
# Set environment variables
$env:KUBECONFIG = $HOME+"/.kube/engagekube"
$viya_namespace = "viya"
$pod = "node-sas-singlestore-cluster-master-0"
# Find endpoints to Singlestore
$s2ip = ($(kubectl -n $viya_namespace get svc | findstr "single" | findstr "LoadBalancer") -split  "\s+")[3]
echo $s2ip