#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Función para mostrar barra de progreso del bucle
print_loop_progress() {
    local current=$1
    local total=$2
    local percent=$((current * 100 / total))
    local filled=$((percent / 2))
    local empty=$((50 - filled))

    echo ""
    echo -e "${MAGENTA}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${NC} Progreso General: Artículo $current de $total"
    printf "${MAGENTA}║${NC} ${CYAN}["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "${CYAN}] ${percent}%%${NC}\n"
    echo -e "${MAGENTA}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Función para mostrar estadísticas finales
show_final_stats() {
    local total=$1
    local successful=$2
    local failed=$3
    local duration=$4

    echo ""
    echo "═══════════════════════════════════════════════════"
    echo -e "${GREEN}✓ Ejecución del bucle completada${NC}"
    echo "═══════════════════════════════════════════════════"
    echo ""
    echo -e "${CYAN}📊 Estadísticas de la sesión:${NC}"
    echo ""
    echo -e "  Total de iteraciones: ${BLUE}$total${NC}"
    echo -e "  Exitosas:            ${GREEN}$successful${NC}"
    echo -e "  Fallidas:            ${RED}$failed${NC}"
    echo -e "  Duración total:      ${YELLOW}${duration}s${NC}"
    echo -e "  Promedio por artículo: ${YELLOW}$(($duration / $total))s${NC}"
    echo ""
    echo "═══════════════════════════════════════════════════"
    echo ""
}

# Banner inicial
clear
echo ""
echo "╔═══════════════════════════════════════════════════╗"
echo "║                                                   ║"
echo "║       🕵️  SEO RALPH CLUSTER - MODO BUCLE  🕵️       ║"
echo "║                                                   ║"
echo "║        Generación Automática de Contenido        ║"
echo "║                                                   ║"
echo "╚═══════════════════════════════════════════════════╝"
echo ""

# Verificar autenticación
echo -e "${YELLOW}⚠️  Verificando configuración...${NC}"
echo ""

if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ ERROR: Claude Code no está instalado${NC}"
    echo -e "${YELLOW}   Instala con: npm install -g @anthropic-ai/claude-code${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Claude Code detectado${NC}"
echo ""

# Contar keywords disponibles
if [ -f "data/keywords.csv" ]; then
    total_keywords=$(($(wc -l < data/keywords.csv) - 1))
    echo -e "${CYAN}ℹ️  Keywords disponibles: $total_keywords${NC}"
else
    echo -e "${RED}❌ ERROR: data/keywords.csv no encontrado${NC}"
    exit 1
fi

echo ""
echo "───────────────────────────────────────────────────"
echo ""

# Solicitar número de artículos
echo -e "${CYAN}¿Cuántos artículos deseas generar?${NC}"
echo -e "${YELLOW}(Máximo recomendado: $total_keywords)${NC}"
echo ""
echo -n "➜ Cantidad: "
read iterations

# Validar input
if ! [[ "$iterations" =~ ^[0-9]+$ ]] || [ "$iterations" -lt 1 ]; then
    echo -e "${RED}❌ ERROR: Debes ingresar un número válido mayor a 0${NC}"
    exit 1
fi

if [ "$iterations" -gt "$total_keywords" ]; then
    echo -e "${YELLOW}⚠️  ADVERTENCIA: Solicitaste $iterations artículos pero solo hay $total_keywords keywords${NC}"
    echo -e "${YELLOW}   Se generarán máximo $total_keywords artículos${NC}"
    iterations=$total_keywords
fi

echo ""
echo "───────────────────────────────────────────────────"
echo ""

# Setup automático de permisos
echo -e "${CYAN}📋 Configuración de permisos:${NC}"
echo ""

# Crear directorio content si no existe
if [ ! -d "content" ]; then
    echo -e "${YELLOW}  • Creando directorio content/...${NC}"
    mkdir -p content
    chmod 755 content
    echo -e "${GREEN}    ✓ Directorio creado con permisos de escritura${NC}"
else
    echo -e "${GREEN}  ✓ Directorio content/ ya existe${NC}"
fi

# Verificar permisos de data/
chmod 755 data
echo -e "${GREEN}  ✓ Permisos configurados en data/${NC}"

echo ""
echo -e "${GREEN}✓ Permisos configurados automáticamente${NC}"
echo -e "${CYAN}  El sistema generará $iterations artículos con permisos pre-concedidos${NC}"
echo ""

# Variables de tracking
successful=0
failed=0
start_time=$(date +%s)

echo "═══════════════════════════════════════════════════"
echo ""
echo -e "${BLUE}🚀 Iniciando generación de $iterations artículos...${NC}"
echo ""
echo "═══════════════════════════════════════════════════"

# Bucle principal
for ((i=1; i<=iterations; i++))
do
    print_loop_progress $i $iterations

    echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│${NC} Ejecutando iteración $i de $iterations"
    echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
    echo ""

    # Ejecutar tarea
    if ./scripts/run_task.sh; then
        ((successful++))
        echo -e "${GREEN}✓ Iteración $i completada exitosamente${NC}"
    else
        ((failed++))
        echo -e "${RED}✗ Iteración $i falló${NC}"
        echo ""
        echo -e "${YELLOW}¿Deseas continuar con las siguientes iteraciones? (s/n)${NC}"
        echo -n "➜ Respuesta: "
        read continue_choice

        if [[ ! "$continue_choice" =~ ^[sS]$ ]]; then
            echo -e "${YELLOW}⚠️  Bucle interrumpido por el usuario${NC}"
            break
        fi
    fi

    # Pausa entre iteraciones (excepto en la última)
    if [ $i -lt $iterations ]; then
        echo ""
        echo -e "${CYAN}⏸️  Esperando 3 segundos antes de la siguiente iteración...${NC}"
        sleep 3
        echo ""
        echo "═══════════════════════════════════════════════════"
    fi
done

# Calcular duración
end_time=$(date +%s)
duration=$((end_time - start_time))

# Mostrar estadísticas finales
show_final_stats $iterations $successful $failed $duration

# Mostrar progreso final
if [ -f "data/progress.txt" ]; then
    echo -e "${CYAN}📊 Estado final del sistema:${NC}"
    echo ""
    cat data/progress.txt
    echo ""
fi

# Exit code basado en resultados
if [ $failed -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todos los artículos generados exitosamente!${NC}"
    echo ""
    exit 0
else
    echo -e "${YELLOW}⚠️  Algunos artículos fallaron - Revisa los logs${NC}"
    echo ""
    exit 1
fi
