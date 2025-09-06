#!/bin/bash

if [ -z "$1" ]; then
  echo "Veuillez spécifier une langue : fr, en, es, ou it."
  exit 1
fi

langue="$1"

case $langue in
  fr)
    echo "Bonjour"
    ;;
  en)
    echo "Hello"
    ;;
  es)
    echo "Hola"
    ;;
  it)
    echo "Ciao"
    ;;
  *)
    echo "Langue non reconnue. Veuillez utiliser fr, en, es, ou it."
    ;;
esac
