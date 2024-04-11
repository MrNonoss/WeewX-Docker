#!/usr/bin/env bash
set -e

exec gosu weewx weewxd "$@"

exec "$@"
