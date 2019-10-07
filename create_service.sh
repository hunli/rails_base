#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NEW_PROJECT_DIR="$(realpath $1)"

validate() {
  if [ "$NEW_PROJECT_DIR" == "" ]; then
    help_menu
    exit 1
  fi
}

help_menu() {
  echo 'Usage: create_service.sh <new_project_path>'
}

create_base_structure() {
  mkdir $NEW_PROJECT_DIR
  copy_base_files $NEW_PROJECT_DIR
}

copy_base_files() {
  cp $SCRIPT_DIR/Dockerfile $NEW_PROJECT_DIR
  cp $SCRIPT_DIR/Gemfile $NEW_PROJECT_DIR
  cp $SCRIPT_DIR/Gemfile.lock $NEW_PROJECT_DIR
  cp $SCRIPT_DIR/Makefile $NEW_PROJECT_DIR
  cp $SCRIPT_DIR/docker-compose.yml $NEW_PROJECT_DIR
  cp $SCRIPT_DIR/entrypoint.sh $NEW_PROJECT_DIR
}

initialize_project() {
  cd $NEW_PROJECT_DIR
  docker-compose run web rails new . --force --no-deps --database=postgresql
  docker-compose build
}

connect_database() {
  cp $SCRIPT_DIR/database.yml $NEW_PROJECT_DIR/config/
}

setup_app() {
  docker-compose up
  docker-compose run web rake db:create
}

validate
create_base_structure
initialize_project
connect_database
setup_app
