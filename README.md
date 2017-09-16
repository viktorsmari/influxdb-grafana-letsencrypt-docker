InfluxDB + Grafana + Nginx + Letsencrypt
=========

### This is a work in progress but should achieve the following:

* Influxdb on port 8086
* Grafana on port 3000
* lets-nginx on ports 80,443 in front, managing SSL certs via letsencrypt


### Ansible "should"
* [X] 1. Copy docker-compose.yml file
* [ ] 2. Start the containers (currently a manual step) - Should we use the `shell` module to perform `docker-compose up -d` ?
* [x] 3. Create admin user for influxdb
* [ ] 4. Enable HTTP_AUTH,  so we won't get hacked, - still a manual process (edit compose file + restart containers)
* [x] 5. Create influxdb databases, users, grants (it does this using the admin account)

### Variables

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

This is UNTESTED on a fresh machine!

1. Run the playbook ( is only able to copy compose file, then fails because docker is not running )
2. SSH into the target server and do `docker-compose up -d`
3. Run the playbook again
4. Change the HTTP_AUTH to 'true'
5. Restart compose?


## Post setup

* When everything is working, you should enable HTTP_AUTH by changing influxdb service in docker-compose environment var to 'true':

      environment:
      - "INFLUXDB_HTTP_AUTH_ENABLED=true"

* And restart containers: `docker-compose up -d`
