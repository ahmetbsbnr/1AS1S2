#!/bin/bash

for i in {2..10}; do
    res="q$i.sh"
    echo $res
done

echo "quelle programme tu veux executer (chiffre) et le parametre (si besoin)"
read pr doss1 doss2 doss3
progr="q$pr.sh" 
./$progr $doss1 $doss2 $doss3

