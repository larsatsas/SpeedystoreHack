# Powershell script to bootstrap Singlestore for use with SAS Viya
# Run this from your home folder inside Powershell
# Prerequisites:
# * kubectl installed and available
# * kubeconfig for your environment downloaded and stored at .kube/engagekube
# * Run from your home folder
# Powershell kode
# Set environment variables
$env:KUBECONFIG = ".kube/engagekube"
$viya_namespace = "viya"
$pod = "node-sas-singlestore-cluster-master-0"

# Get the password from the Kubernetes secret
$secret = kubectl -n $viya_namespace get secret sas-singlestore-cluster -o json
$passwordEncoded = ($secret | ConvertFrom-Json).data.ROOT_PASSWORD
$password = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($passwordEncoded))

# now with a fix on the new line...
# Create post_config.sql
@"
SET GLOBAL table_name_case_sensitivity = OFF;
SET CLUSTER collation_server = 'utf8mb4_bin';
CREATE USER IF NOT EXISTS 'sas' IDENTIFIED BY 'Orion123';
CREATE DATABASE IF NOT EXISTS myDB;
CREATE DATABASE IF NOT EXISTS S2Work;
GRANT SHOW METADATA ON *.* to 'sas';
GRANT ALL ON myDB.* TO 'sas';
GRANT ALL ON S2Work.* TO 'sas';
"@ | Set-Content -Path "post_config.sql" -NoNewline

# Create setupS2.sh
@"
export MYSQL_PWD=$password
singlestore < /tmp/post_config.sql
"@ | Set-Content -Path "setupS2.sh" -NoNewline


# Copy files to the pod
kubectl -n $viya_namespace cp post_config.sql "${pod}:/tmp"
kubectl -n $viya_namespace cp setupS2.sh "${pod}:/tmp"

# Execute the setup script inside the pod
kubectl -n $viya_namespace exec $pod -- /bin/bash /tmp/setupS2.sh

# Find endpoints to Singlestore
kubectl -n $viya_namespace get svc | findstr "single"

