#!/bin/bash
set -euo pipefail

for f in *; do
    new=$(echo "$f" \
        | tr '[:upper:]' '[:lower:]' \
        | tr ' _' '-' \
        | sed 's/[^a-z0-9._-]//g')

    if [ "$f" != "$new" ]; then
        mv -- "$f" "$new"
        echo "$f -> $new"
    fi
done

