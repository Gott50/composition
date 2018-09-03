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

### .nginx.env
    APP_DIR=/app
    APP_PATH_PREFIX=/aSubSiteInParentDomainUseThisPath
    APP_API_PLACEHOLDER=/allRequestStartOfthisPathIsAnApiCall
    APP_API_GATEWAY="https://api.36node.com"
    CLIENT_BODY_TIMEOUT=10
    CLIENT_HEADER_TIMEOUT=10
    CLIENT_MAX_BODY_SIZE=1024
    WHITE_LIST_IP=(172.17.0.1)|(192.168.0.25)
    WHITE_LIST=off