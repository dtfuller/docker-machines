#!/bin/bash
set -e

for entrypoint in /docker-entrypoint.d/* ; do
	if [[ -e $entrypoint ]]; then
		$entrypoint
	fi
done

exec "$@"

