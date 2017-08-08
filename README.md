GO Test
--------

## Docker image

### Build image
    docker build -t clarenceyou/log-sample .

### Tag image
    docker tag [image-id] clarenceyou/log-sample:1.0.0

### Run container
    docker run -d clarenceyou/log-sample:1.0.0


minishift start --iso-url centos
minishift start --iso-url centos --docker-opt log-driver=journald
minishift start --iso-url centos --docker-opt log-driver=journald --logging

oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:logging:aggregated-logging-elasticsearch

oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:logging:aggregated-logging-kibana 

oc adm policy add-cluster-role-to-user cluster-admin developer

MINI_TOKEN=$(oc whoami -t)
eval $(minishift docker-env)
docker login -u developer -p ${MINI_TOKEN} 172.30.1.1:5000 
cd $GOPATH/src/yougroupteam/you-gps
docker build -t log-sample:latest .
docker tag log-sample:latest 172.30.1.1:5000/myproject/log-sample:latest
docker push 172.30.1.1:5000/myproject/log-sample:latest
oc deploy --latest gotest


curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XGET "https://$ES_HOST:$ES_PORT"
curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XGET "https://$ES_HOST:$ES_PORT/_cat/health?v"
curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XGET "https://$ES_HOST:$ES_PORT/_cat/indices?v"

### Check index settings
curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XGET "https://$ES_HOST:$ES_PORT/_all/_settings"
curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XGET "https://$ES_HOST:$ES_PORT/project.myproject*/_settings"

### Check index mapping
curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XGET "https://$ES_HOST:$ES_PORT/project.myproject*/_mapping"

curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XPOST "https://$ES_HOST:$ES_PORT/_msearch"


curl --cacert $ES_CA --key $ES_CLIENT_KEY --cert $ES_CLIENT_CERT -s -w "%{http_code}" -XPOST -H "Content-Type: text/plain" --data "[ERROR]"  "https://$ES_HOST:$ES_PORT/_analyze?analyzer=standard"