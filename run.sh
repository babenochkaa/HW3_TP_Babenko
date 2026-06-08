#!/bin/bash

COMMAND=$1

case $COMMAND in

  build_generator)
    docker build -t hw3-generator ./generator
    ;;

  run_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hw3-generator
    ;;

  create_local_data)
    mkdir -p local_data
    python generator/generate.py local_data
    ;;

  build_reporter)
    docker build -t hw3-reporter ./reporter
    ;;

  run_reporter)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hw3-reporter
    ;;

  structure)
    find . -print
    ;;

  clear_data)
    mkdir -p data
    rm -f data/*.csv
    rm -f data/*.html
    ;;

  inside_generator)
    docker run --rm -v "$(pwd)/data:/data" hw3-generator ls -la /data
    ;;

  inside_reporter)
    docker run --rm -v "$(pwd)/data:/data" hw3-reporter ls -la /data
    ;;

  report_server)
    docker run --rm -p 8080:80 -v "$(pwd)/data:/usr/share/nginx/html" nginx:alpine
    ;;

  *)
    echo "Unknown command"
    echo "Available commands:"
    echo "  build_generator"
    echo "  run_generator"
    echo "  create_local_data"
    echo "  build_reporter"
    echo "  run_reporter"
    echo "  structure"
    echo "  clear_data"
    echo "  inside_generator"
    echo "  inside_reporter"
    echo "  report_server"
    ;;

esac