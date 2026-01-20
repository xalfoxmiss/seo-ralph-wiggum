#!/bin/bash
echo "🕵️  Iniciando Motor Ralph..."
echo "⚠️  Asegúrate de haber ejecutado 'claude init'."
echo "¿Cuántos artículos quieres generar?"
read iterations

for ((i=1; i<=iterations; i++))
do
   echo "--- Iteración $i de $iterations ---"
   ./scripts/run_task.sh
   echo "--- Completada. Esperando 2s... ---"
   sleep 2
done
