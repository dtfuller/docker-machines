#!/bin/bash

function exec_in_container(){
    docker exec -u python -it pc "$@"
}

function exec_in_container_as_root(){
    docker exec -u root -it pc "$@"
}

function destroy_container(){
    docker stop -t 0 pc
    docker rm pc
}

function create_container(){
    docker create --name pc dtfuller/python3:0.1
    docker start pc
}

function build_image_with_cache(){
    docker build -f ./python3.dockerfile -t dtfuller/python3:0.1 .
}

function build_image_without_cache(){
    docker build --no-cache -f ./python3.dockerfile -t dtfuller/python3:0.1 .
}

function eploy(){
    build_image_without_cache
    destroy_container
    create_container
    exec_in_container bash
}

function full_deploy(){
    build_image_with_cache
    destroy_container
    create_container
    exec_in_container bash
}


alias c="exec_in_container bash"
alias cr="exec_in_container_as_root bash"
alias d="deploy"
alias fd="full_deploy"
alias h="cat .workflow | grep alias"
alias w=". .workflow"
alias vw="vim .workflow"
