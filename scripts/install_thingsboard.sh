#!/bin/bash

set -x

# Update and install prerequisites
sudo apt update -y
sudo apt install -y openjdk-17-jdk 

# Automated repository configuration:
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# install and launch the postgresql service:
sudo apt update
sudo apt -y install postgresql-16
sudo service postgresql start

# Set password and create database
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'Thingsboard@123';"
sudo -u postgres psql -c "CREATE DATABASE thingsboard;"

# Download and install ThingsBoard
wget https://github.com/thingsboard/thingsboard/releases/download/v3.9.1/thingsboard-3.9.1.deb
sudo dpkg -i thingsboard-3.9.1.deb

# Configure ThingsBoard
sudo tee -a /etc/thingsboard/conf/thingsboard.conf <<EOF
export DATABASE_TS_TYPE=sql
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=Thingsboard@123
export SQL_POSTGRES_TS_KV_PARTITIONING=MONTHS
EOF

# Fix: CD into correct directory before running the installer!
cd /usr/share/thingsboard

# Install demo data from correct path
sudo ./bin/install/install.sh --loadDemo

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl start thingsboard
sudo systemctl enable thingsboard
sudo systemctl status thingsboard