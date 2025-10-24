#!/bin/bash
#ddev stop --unlist *
ddev start
ddev import-db --file=database_backup.sql.gz
ddev composer install
#ddev composer update --lock
ddev drush cr
ddev drush updb -y
ddev drush cim -y
ddev drush cr