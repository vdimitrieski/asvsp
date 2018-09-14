#!/bin/bash
#Skripta pokretanje zadatka 1

# Komanda pomocu koje se vrsi ispis svake komand pre pokretanja
#set -o xtrace

# Zaustavljanje postojecih kontejnera i brisanje resursa (radi ponovnog pokretanja skripte)
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker build -t zadatak1:1.0 .
docker run -d --name zadatak1 -p 8080:80 zadatak1:1.0

#set +o xtrace
