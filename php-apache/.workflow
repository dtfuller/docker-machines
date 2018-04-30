#!/bin/bash 
function build_image(){
    docker build -t dtfuller/php-apache:0.1 -f ./php-apache.dockerfile . 
}

function deploy_container(){
    docker stop -t 0 test;
    docker rm test;
    docker create --name test dtfuller/php-apache:0.1;
    docker start test;
    docker exec -it test bash;
}

function full_deploy(){
    build_image; 
    deploy_container;
}

function help(){
    cat .workflow;
}


alias b="build_image";
alias d="deploy_container";
alias f="full_deploy";
alias h="help | grep alias";
alias w=". .workflow";
alias vw="vim .workflow";


