# ElasticSearch & Kibana (Quick k8s dev setup)

[![N|Solid](https://i.imgur.com/Q5bCDOH.pngg)](https://nodesource.com/products/nsolid)

If you need a way to quickly deploy Kibana + ElasticSearch for testing/development, this is the repo for you. It's a very basic deployment that sets up a single pod elasticsearch & kibana deployment. The elasticsearch service is exposed internally (ClusterIP) while the Kibana deployment is exposed externally (NodePort).

**WARNING:** Ensure you are using a locked-down security group! Kibana is deployed without authentication and is accessible from the k8s worker node port 32601.

### deploy.sh script
```bash
# To deploy stack.
$ chmod +x deploy.sh
$ ./deploy.sh -d
# To destroy stack.
$ ./deploy.sh -r
```

### generateData.sh script
```bash
# Generate "linux_books" index with 90+ JSON records.
./generateData.sh
```
