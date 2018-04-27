#!/bin/bash
alias w=". workflow.sh"
alias d=./deploy.sh
alias c="docker exec -it test-ps bash"
alias r="docker exec -u root -it test-ps bash"
alias t=". ./toggle-cache.sh"

export BUILD_WITH_CACHE='true';
