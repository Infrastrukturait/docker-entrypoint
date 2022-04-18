#!/bin/sh
# bugs report to
# Infrastruktura.IT DevOps Team <maintainers-docker@infrastruktura.it>

set -e

if [[ -d /docker-entrypoint.d ]]; then

    echo "$0: Looking for shell scripts in /docker-entrypoint.d/" >&1
    for file in /docker-entrypoint.d/*; do
        echo "---> $file"
        case "$file" in
            *.sh)
                if [ -x "$file" ]; then
                    echo "$0: Launching $file" >&1
                    "$file"
                else
                    # err on shell scripts without exec bit
                    echo "$0: Ignoring $file, not executable" >&2
                fi
                ;;
            *) echo "$0: Ignoring $file" >&2;;
        esac
    done

    echo "$0: Configuration complete; ready or start up" >&1
else
    echo "$0: No files found in /docker-entrypoint.d/, skipping configuration" >&1
fi

exec "$@"

# vim:sw=4:ts=4:et
