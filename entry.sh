#!/usr/bin/env bash
set -e

rsyslogd 
exec gosu weewx weewxd "$@"

exec "$@"
