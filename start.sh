#!/bin/bash

rm -f /myapp/tmp/pids/server.pid


bundle exec puma
