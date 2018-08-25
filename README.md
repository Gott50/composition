## Start Services
    docker-compose up

## after First Start: init DB
    docker-compose run manager python create_db.py

## update Submodules
    git submodule update --remote --recursive
    
## add .env Files
### .postgres.env
    DB_NAME=postgres
    DB_USER=postgres
    DB_PASS=postgres

### .api.env
    SECRET_KEY=5(15ds+i2+%ik6z&!yer+ga9m=e%jcqiz_5wszg)r-z!2--b2d
    PATH_TO_SSH_KEY=tk
    SSH_PORT=tk
    IP=tk
    SECURITY_PASSWORD_SALT=tk