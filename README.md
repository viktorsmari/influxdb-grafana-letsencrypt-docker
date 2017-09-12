InfluxDB + Grafana + Nginx + Letsencrypt
=========

### The following containers will be created:

* Influxdb on port 8086
* Grafana on port 3000
* lets-nginx on ports 80,443 in front, managing SSL certs via letsencrypt


### Variables

Modify and put the following in your playbook:

    - hosts: example.com
      vars:
        influxdb_admin_password: "influxadminpass"
        influxdb_database: 'mydatabase'
        influxdb_username: 'myuser'
        influxdb_password: 'mypassword'
        influx_url: "influxdb.example.com"
        grafana_url: "grafana.example.com"
        grafana_admin_password: "adminpass"
        grafana_root_url: "https://grafana.example.com"
        grafana_anonymous_enabled: "false"
        https_portal_domains: '{{influx_url}} -> http://influxdb:8086, {{grafana_url}} -> http://grafana:3000'

### Start

SSH into the target server and do `docker-compose up -d`


## TODO:

* Find a way to automatically create all the databases + users in the Influxdb container.

* Currently we have tu run the script under templates/createInfluxDb.sh

