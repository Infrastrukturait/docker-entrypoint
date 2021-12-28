#!/bin/sh
# bugs report to 
# Infrastruktura.IT DevOps Team <maintainers-docker@infrastruktura.it>

set -e

if [[ -d /docker-entrypoint.d ]]; then

    shopt -s nullglob

    echo >&3 "$0: Looking for shell scripts in /docker-entrypoint.d/"
    for file in /docker-entrypoint.d/*; do
        case "$file" in
            *.sh)
                if [ -x "$f" ]; then
                    echo >&3 "$0: Launching $f";
                    "$f"
                else
                    # warn on shell scripts without exec bit
                    echo >&3 "$0: Ignoring $f, not executable";
                fi
                ;;
            *) echo >&3 "$0: Ignoring $f";;
        esac
    done

    echo >&3 "$0: Configuration complete; ready for start up"
else
    echo >&3 "$0: No files found in /docker-entrypoint.d/, skipping configuration"
fi

exec "$@"

# vim:sw=4:ts=4:et
