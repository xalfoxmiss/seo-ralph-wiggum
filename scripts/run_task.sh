#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para mostrar barra de progreso
print_progress() {
    local step=$1
    local total=$2
    local message=$3
    local percent=$((step * 100 / total))
    local filled=$((percent / 2))
    local empty=$((50 - filled))

    printf "\r${CYAN}[${NC}"
    printf "%${filled}s" | tr ' ' '='
    printf "%${empty}s" | tr ' ' '-'
    printf "${CYAN}] ${percent}%% ${NC}${message}"
}

echo ""
echo "═══════════════════════════════════════════════════"
echo -e "${BLUE}🕵️  SEO Ralph Cluster - Modo Agente Autónomo${NC}"
echo "═══════════════════════════════════════════════════"
echo ""

# Paso 1: Validación de requisitos
print_progress 1 6 "Validando requisitos del sistema..."
echo ""

# Verificar que Claude Code está instalado
if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ ERROR: Claude Code no está instalado${NC}"
    echo -e "${YELLOW}   Instala con: npm install -g @anthropic-ai/claude-code${NC}"
    exit 1
fi

# Paso 2: Validación de archivos de configuración
print_progress 2 6 "Verificando archivos de configuración..."
echo ""

required_files=(
    "docs/brand_context.md"
    "docs/style_guide.md"
    "docs/system_instructions.md"
    "estrategia_seo.md"
    "data/keywords.csv"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ ERROR: Archivo requerido no encontrado: $file${NC}"
        exit 1
    fi
done

# Paso 3: Verificar/crear directorio content
print_progress 3 6 "Preparando directorio de contenido..."
echo ""

if [ ! -d "content" ]; then
    echo -e "${YELLOW}⚠️  Directorio 'content/' no existe${NC}"
    echo -e "${CYAN}   Se solicitará permiso a Claude para crearlo${NC}"
fi

# Paso 4: Validar keywords disponibles
print_progress 4 6 "Verificando keywords disponibles..."
echo ""

keyword_count=$(wc -l < data/keywords.csv)
if [ "$keyword_count" -le 1 ]; then
    echo -e "${RED}❌ ERROR: No hay keywords en data/keywords.csv${NC}"
    echo -e "${YELLOW}   Añade keywords antes de ejecutar el sistema${NC}"
    exit 1
fi

# Paso 5: Preparación completa
print_progress 5 6 "Sistema validado - Iniciando agente Claude..."
echo ""
echo ""

# Paso 6: Ejecutar Claude
print_progress 6 6 "Ejecutando generación de contenido SEO..."
echo ""
echo ""
echo -e "${GREEN}✓ Iniciando Ralph Agent...${NC}"
echo ""
echo "───────────────────────────────────────────────────"
echo ""

# Llamar a Claude con instrucciones detalladas
claude -p "Estás en modo agente autónomo (Ralph).

IMPORTANTE: Este sistema requiere permisos explícitos. Lee docs/permissions_system.md para entender el flujo.

FLUJO DE EJECUCIÓN:
1. LEE PRIMERO: docs/brand_context.md, docs/style_guide.md, docs/system_instructions.md y docs/permissions_system.md
2. LEE LUEGO: estrategia_seo.md y data/keywords.csv
3. SOLICITA PERMISOS necesarios antes de crear/modificar archivos
4. EJECUTA: Una iteración completa de creación de contenido
5. MUESTRA PROGRESO en consola con detalles de:
   - Keyword seleccionada
   - Estado de generación
   - Enlaces internos añadidos
   - Próxima keyword
6. FINALIZA: Actualizando data/progress.txt con estadísticas

CONTROL DE PROCESO:
- Indica claramente cada paso que estás realizando
- Solicita confirmación antes de crear/modificar archivos
- Muestra el progreso de forma visual
- Reporta estadísticas al finalizar"

# Verificar resultado de la ejecución
exit_code=$?

echo ""
echo "───────────────────────────────────────────────────"
echo ""

if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✓ Iteración completada exitosamente${NC}"
    echo ""

    # Mostrar estado actual del progreso
    if [ -f "data/progress.txt" ]; then
        echo -e "${CYAN}📊 Estado actual:${NC}"
        echo ""
        cat data/progress.txt
        echo ""
    fi
else
    echo -e "${RED}❌ Error durante la ejecución (código: $exit_code)${NC}"
    echo -e "${YELLOW}   Revisa los logs anteriores para más detalles${NC}"
    exit $exit_code
fi

echo "═══════════════════════════════════════════════════"
echo ""
