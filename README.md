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

* Currently we must run the script under templates/createInfluxDb.sh which does the following:

      curl -G "https://{{influx_url}}/query" --data-urlencode "q=create user admin with password '{{influxdb_admin_password}}' WITH ALL PRIVILEGES"
      curl -G "https://{{influx_url}}/query?u=admin&p={{influxdb_admin_password}}" --data-urlencode "q=create database {{influxdb_database}}"
      curl -G "https://{{influx_url}}/query?u=admin&p={{influxdb_admin_password}}" --data-urlencode "q=create user {{influxdb_username}} with password {{influxdb_password}}"
      curl -G "https://{{influx_url}}/query?u=admin&p={{influxdb_admin_password}}" --data-urlencode "q=grant all on {{influxdb_database}} to {{influxdb_username}}"


## Post setup

* When everything is working, you should enable HTTP_AUTH by changing influxdb service in docker-compose environment var to 'true':

      environment:
      - "INFLUXDB_HTTP_AUTH_ENABLED=true"

