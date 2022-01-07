#!/bin/bash

for i in "$@"; do
  case $i in
    -a=*|--version_service1=*)
      SERVICE1="${i#*=}"
      shift # past argument=value
      ;;
    -b=*|--version_service2=*)
      SERVICE2="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

echo "Version service 1 = ${SERVICE1}"
echo "Version service 2 = ${SERVICE2}"

if [[ -z $SERVICE1 || -z $SERVICE2 ]]; then
    echo "Both versions of services have to be specified!"
    exit 1
fi

cat << EOF > docker-compose-versioned.yml
version: "3.9"

services:
  service1:
    image: alexmilis/service1:$SERVICE1
    ports:
      - "8080:8080"
  service2:
    image: alexmilis/service2:$SERVICE2
    ports:
      - "8081:8080"
    depends_on:
      - service1
EOF

docker-compose -f docker-compose-versioned.yml up
