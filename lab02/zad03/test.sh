#!/bin/bash

# Testowanie czy Dockerfile istnieje
if [ ! -f "Dockerfile" ]; then
  echo "Błąd: Brak pliku Dockerfile."
  exit 1
fi


if [ ! -f "package.json" ]; then
  echo "Błąd: Brak pliku package.json."
  exit 1
fi

if [ ! -f "index.js" ]; then
  echo "Błąd: Brak pliku index.js."
  exit 1
fi

docker --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Błąd: Docker nie jest zainstalowany."
  exit 1
fi

docker ps | grep mongo-container > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Błąd: Kontener z bazą danych MongoDB nie jest uruchomiony."
  exit 1
fi

docker ps | grep express-app > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Błąd: Kontener z aplikacją Express.js nie został utworzony."
  exit 1
fi

echo "Testy zakończone pomyślnie."