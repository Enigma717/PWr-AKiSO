#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)
bold=$(tput bold)
resetcursor=$(tput sgr0)


curl -s -o joke.json http://api.icndb.com/jokes/random
curl -s -o cat.png https://cataas.com/cat

joke=$(jq '.value.joke' joke.json) 


catimg -w 250 cat.png

printf "\n\n$red=====[$cyan$bold JOKE $resetcursor$red]============================================\n"
printf "\n$green $joke\n"
printf "\n$red=========================================================$resetcursor\n\n"

