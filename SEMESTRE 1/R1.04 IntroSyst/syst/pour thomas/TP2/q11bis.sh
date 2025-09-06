#!/bin/bash

select choix in 'ls' "quitter" ; do
    if [ $choix == "quitter" ] ; then
        break
    else
        ./$choix
    fi
done