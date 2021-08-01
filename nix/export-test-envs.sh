#!/bin/sh

#
# app
#

export BINANCE_CLIENT_LOG_ENV="dev"
export BINANCE_CLIENT_LOG_FORMAT="Bracket" # Bracket | JSON
export BINANCE_CLIENT_LOG_VERBOSITY="V3"
export BINANCE_CLIENT_LIBPQ_CONN_STR="postgresql://nixbld1@localhost/binance-client"
export BINANCE_CLIENT_ENDPOINT_PORT="3000"
