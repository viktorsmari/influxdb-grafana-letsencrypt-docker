
# create user admin with all privileges
curl -G "https://{{influx_url}}/query" --data-urlencode "q=create user admin with password '{{influxdb_admin_password}}' WITH ALL PRIVILEGES"

curl -G "https://{{influx_url}}/query?u=admin&p={{influxdb_admin_password}}" --data-urlencode "q=create database {{influxdb_database}}"

curl -G "https://{{influx_url}}/query?u=admin&p={{influxdb_admin_password}}" --data-urlencode "q=create user {{influxdb_username}} with password {{influxdb_password}}"

curl -G "https://{{influx_url}}/query?u=admin&p={{influxdb_admin_password}}" --data-urlencode "q=grant all on {{influxdb_database}} to {{influxdb_username}}"

