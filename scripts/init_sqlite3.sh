#!/bin/bash

source .env
cat scripts/create_programs.sql | sqlite3 "$SQLITE_DB_FILE"
