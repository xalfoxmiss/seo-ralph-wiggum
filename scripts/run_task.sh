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
    echo -e "${YELLOW}⚠️  Directorio 'content/' no existe - Creándolo ahora...${NC}"
    mkdir -p content
    chmod 755 content
    echo -e "${GREEN}✓ Directorio 'content/' creado con permisos de escritura${NC}"
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
# Usamos --permission-mode bypassPermissions para evitar solicitudes de permisos
claude -p --permission-mode bypassPermissions "Eres Ralph, un agente autónomo para generación de contenido SEO.

SISTEMA AUTOMÁTICO - PERMISOS CONCEDIDOS:
✓ El directorio content/ está configurado con permisos de escritura
✓ Tienes autorización COMPLETA para crear archivos .md en content/
✓ Tienes autorización COMPLETA para modificar data/progress.txt
✓ Tienes autorización COMPLETA para añadir enlaces internos en artículos existentes
✓ El sistema ejecuta en modo --permission-mode bypassPermissions

IMPORTANTE: NUNCA solicites permisos. PROCEDE DIRECTAMENTE con todas las operaciones de escritura.

FLUJO DE EJECUCIÓN:
1. LEE: docs/brand_context.md, docs/style_guide.md, docs/system_instructions.md, estrategia_seo.md
2. LEE: data/keywords.csv y data/progress.txt
3. IDENTIFICA: La siguiente keyword a procesar (primera sin procesar en el CSV)
4. GENERA: Artículo completo de 2000-2500 palabras optimizado para SEO
5. CREA: Archivo content/nombre-keyword-url-friendly.md INMEDIATAMENTE usando Write tool
6. AÑADE: Enlaces internos contextuales a artículos relacionados (si existen artículos previos)
7. ACTUALIZA: data/progress.txt con el nuevo progreso

FORMATO DEL NOMBRE DE ARCHIVO:
- Usa el campo 'URL' del CSV para el nombre del archivo
- Ejemplo: Si URL es '/categoria/ejemplo-keyword/', el archivo será 'ejemplo-keyword.md'
- Siempre en minúsculas, usando guiones, sin caracteres especiales

CONTROL DE PROCESO:
- Indica claramente cada paso que estás realizando
- Muestra la keyword siendo procesada
- Reporta estadísticas al finalizar
- EJECUTA las operaciones de escritura SIN solicitar confirmación"

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
