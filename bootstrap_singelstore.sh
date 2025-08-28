export KUBECONFIG=.kube/engagekube
export viya_namespace=viya
export pod=node-sas-singlestore-cluster-master-0
password=$(kubectl -n $viya_namespace get secret sas-singlestore-cluster -o yaml|grep "ROOT_PASSWORD"|awk '{print $2}'|base64 -d --wrap=0)
# Setup Singlestore
cat <<EOF > post_config.sql
SET GLOBAL table_name_case_sensitivity = OFF;
SET CLUSTER collation_server = 'utf8mb4_bin';
CREATE USER IF NOT EXISTS '${db_user}' IDENTIFIED BY '${db_pass}';
CREATE DATABASE IF NOT EXISTS ${db_name};
CREATE DATABASE IF NOT EXISTS ${epdb_name};
GRANT SHOW METADATA ON *.* to '${db_user}';
GRANT ALL ON ${db_name}.* TO '${db_user}';
GRANT ALL ON ${epdb_name}.* TO '${db_user}';
EOF
# Start the setup
cat <<EOF > ${workdir}/setupS2.sh
export MYSQL_PWD=$password
singlestore < /tmp/post_config.sql
EOF
# Copy files to the pod
kubectl -n $viya_namespace cp post_config.sql "${pod}:/tmp"
kubectl -n $viya_namespace cp setupS2.sh "${pod}:/tmp"
# Start the setup script at this pod
kubectl -n $viya_namespace exec $pod -- /bin/bash /tmp/setupS2.sh
# Find endpoints to Singlestore-ddl
kubectl -n $viya_namespace get svc | grep ddl
