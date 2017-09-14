InfluxDB + Grafana + Nginx + Letsencrypt
=========

### The following containers will be created:

* Influxdb on port 8086
* Grafana on port 3000
* lets-nginx on ports 80,443 in front, managing SSL certs via letsencrypt


# Steps for ansible
  1. Copies docker-compose.yml file
  2. Starts the containers (currently a manual step)
  3. Creates admin user
  4. Enable HTTP_AUTH,  so we won't get hacked, - still a manual process (edit compose file + restart containers)
  5. Creates influxdb databases, users, grants (with the admin account)

### Variables

Should create:

* 1 admin user
* 1 user
* All the databases given
* Grant those users 'ALL' (read+write) to their databases

Modify and put the following in your playbook:

    - hosts: myserver
      vars:
        influxdb_admin_password: "influxadminpass"
        influxdb_users:
          - { db: 'user1db', username: 'user1', password: 'pass1' }
          - { db: 'user2db', username: 'user2', password: 'pass2' }
        influx_url: "influxdb.example.com"
        grafana_url: "grafana.example.com"
        grafana_admin_password: "adminpass"
        grafana_root_url: "https://grafana.example.com"
        grafana_anonymous_enabled: "false"
        https_portal_domains: '{{influx_url}} -> http://influxdb:8086, {{grafana_url}} -> http://grafana:3000'

### Start

SSH into the target server and do `docker-compose up -d`


## Post setup

* When everything is working, you should enable HTTP_AUTH by changing influxdb service in docker-compose environment var to 'true':

      environment:
      - "INFLUXDB_HTTP_AUTH_ENABLED=true"

* And restart containers: `docker-compose up -d`
