#!/bin/bash
COUCHDBDIR="/usr/lib/couchdb"
COUCHDBBINDIR="$COUCHDBDIR/bin"
COUCHDBETCDIR="$COUCHDBDIR/etc"
COUCHDBCONFIGDIR="/etc/couchdb"

export ERL_FLAGS="-couch_ini $COUCHDBETCDIR/default.ini $COUCHDBCONFIGDIR/local.ini"

echo "Welcome!"
echo "Starting CouchDB"

COUCHDB_BIN_DIR=$(cd $COUCHDBBINDIR && pwd)
ERTS_BIN_DIR=$COUCHDB_BIN_DIR/../
cd "$COUCHDB_BIN_DIR/../"

export ROOTDIR=${ERTS_BIN_DIR%/*}

START_ERL=`cat "$ROOTDIR/releases/start_erl.data"`
ERTS_VSN=${START_ERL% *}
APP_VSN=${START_ERL#* }

export BINDIR="$ROOTDIR/erts-$ERTS_VSN/bin"
export EMU=beam
export PROGNAME=`echo $0 | sed 's/.*\///'`

exec "$BINDIR/erlexec" -boot "$ROOTDIR/releases/$APP_VSN/couchdb" \
     -args_file "$COUCHDBCONFIGDIR/vm.args" \
     -config "$ROOTDIR/releases/$APP_VSN/sys.config"
