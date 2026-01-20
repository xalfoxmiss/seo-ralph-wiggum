# SEO Ralph Cluster - Guía de Ejecución

## Cómo Ejecutar el Sistema

### Configuración Inicial

1. **Preparar archivos de configuración:**
   - Edita `docs/brand_context.md` con la información de tu marca
   - Edita `data/keywords.csv` con tus keywords objetivo
   - Revisa `docs/style_guide.md` para ajustar el estilo de contenido

2. **Verificar permisos del sistema:**
   ```bash
   chmod +x scripts/*.sh
   ```

3. **Leer documentación del sistema:**
   - Revisa `docs/permissions_system.md` para entender el modo automático
   - El sistema opera con permisos pre-configurados (no solicita confirmaciones)

### Ejecución del Sistema

#### Opción 1: Ejecución Manual (Recomendado para pruebas)

```bash
# Linux/Mac
./scripts/run_task.sh
```

**Características:**
- ✅ Validación automática de requisitos
- ✅ Barra de progreso visual (6 pasos)
- ✅ Verificación de archivos de configuración
- ✅ Ejecución automática sin solicitudes de permisos
- ✅ Feedback detallado en consola con colores
- ✅ Resumen de estadísticas al finalizar

**Flujo de ejecución:**
1. Valida que Claude Code está instalado
2. Verifica archivos de configuración requeridos
3. Prepara directorio `content/` automáticamente
4. Valida keywords disponibles en CSV
5. Ejecuta el agente Claude Ralph en modo automático (`--permission-mode bypassPermissions`)
6. Muestra estado final en `progress.txt`

---

#### Opción 2: Ejecución Automática en Bucle

```bash
# Linux/Mac
./scripts/run_loop.sh
```

**Características:**
- ✅ Banner visual profesional
- ✅ Validación de configuración
- ✅ Contador de keywords disponibles
- ✅ Configuración automática de permisos
- ✅ Barra de progreso del bucle completo
- ✅ Tracking de artículos exitosos/fallidos
- ✅ Estadísticas finales (total, exitosos, fallidos, duración)
- ✅ Opción de continuar/detener ante fallos

**Flujo de ejecución:**
```
1. Sistema muestra banner y verifica Claude Code
2. Cuenta keywords disponibles en CSV
3. Solicita: ¿Cuántos artículos generar?
4. Valida que no exceda keywords disponibles
5. Configura automáticamente permisos y directorios
6. Ejecuta bucle con barra de progreso (modo automático)
7. Muestra estadísticas finales
```

**Ejemplo de salida:**
```
╔═══════════════════════════════════════════════════╗
║       🕵️  SEO RALPH CLUSTER - MODO BUCLE  🕵️       ║
╚═══════════════════════════════════════════════════╝

✓ Claude Code detectado
ℹ️  Keywords disponibles: 20

¿Cuántos artículos deseas generar?
➜ Cantidad: 5

📋 Configuración del sistema:
  ✓ Directorio content/ ya existe
  ✓ Permisos configurados en data/

✓ Sistema configurado en modo automático
  Se generarán 5 artículos sin solicitar confirmaciones
  Modo: --permission-mode bypassPermissions

╔════════════════════════════════════════════════════╗
║ Progreso General: Artículo 3 de 5
║ [████████████████████░░░░░░░] 60%
╚════════════════════════════════════════════════════╝

📊 Estadísticas de la sesión:
  Total: 5
  Exitosas: 5
  Fallidas: 0
  Duración: 120s
  Promedio: 24s

🎉 ¡Todos los artículos generados exitosamente!
```

---

### Sistema de Ejecución Automática

**IMPORTANTE:** El sistema opera en modo completamente automático sin solicitar confirmaciones.

#### Modo Automático (`--permission-mode bypassPermissions`)

El sistema está configurado para:
- ✅ Crear archivos automáticamente en `content/`
- ✅ Modificar archivos existentes para enlaces internos
- ✅ Actualizar `data/progress.txt` automáticamente
- ✅ Configurar permisos de directorios automáticamente

**Operaciones Automáticas:**

**1. Crear artículos nuevos**
```bash
Write("content/nombre-keyword-url.md", contenido)
```
- Ejecuta INMEDIATAMENTE sin solicitar confirmación
- Usa el campo URL del CSV para el nombre del archivo
- Ejemplo: URL `/categoria/ejemplo/` → archivo `ejemplo.md`

**2. Actualizar progreso**
```bash
Edit("data/progress.txt", old_content, new_content)
```
- Actualiza automáticamente después de cada artículo
- Registra keyword procesada, timestamp y estadísticas

**3. Enlaces internos**
```bash
Edit("content/articulo-existente.md", contenido_actual, contenido_con_enlaces)
```
- Añade enlaces contextuales automáticamente
- Solo AÑADE contenido, NUNCA elimina

#### Protecciones del Sistema

1. **No sobrescribe archivos existentes** - Verifica antes de crear
2. **No borra contenido** - Solo añade enlaces internos
3. **Scope limitado** - Solo opera en `content/` y `data/`
4. **Nombres URL-friendly** - Validación automática de nombres

📖 **Documentación completa:** `docs/permissions_system.md`

---

## Sistema de Verificación

Antes de ejecutar en producción, verifica que:

- [ ] Claude Code está instalado (`claude --version`)
- [ ] Autenticación completada (`claude init`)
- [ ] Scripts tienen permisos de ejecución (`chmod +x scripts/*.sh`)
- [ ] `docs/brand_context.md` está personalizado
- [ ] `data/keywords.csv` tiene keywords válidas (>0)
- [ ] Has leído `docs/permissions_system.md`

**Validación automática:**
Los scripts ahora validan automáticamente estos requisitos antes de ejecutar.

---

## Monitoreo del Progreso

### En Tiempo Real (Consola)

El sistema muestra durante la ejecución:

```
📍 Keyword: "ejemplo keyword"
📊 Volumen: 1000 | Dificultad: 30 | Intención: informational

⏳ Generando artículo...
✓ Artículo generado (1500 palabras)

🔗 Enlaces añadidos:
- articulo-1.md (1 enlace contextual)
- articulo-2.md (1 enlace contextual)

➡️  Siguiente: "otra keyword"

✓ Iteración completada
📊 Progreso: 5/20 artículos (25%)
```

### Archivo de Progreso

El sistema actualiza `data/progress.txt` automáticamente:

```
Ralph SEO Cluster - Progreso de Ejecución
===========================================

Última ejecución: 2026-01-20 15:30:00
Artículos generados: 5
Progreso total: 5/20 (25%)

Último artículo generado:
- Fecha: 2026-01-20 15:30:00
- Keyword: ejemplo keyword
- Posición actual: 5
- Volumen de búsqueda: 1000

Siguiente keyword: otra keyword
```

---

## Características de los Scripts Mejorados

### run_task.sh
- 🎨 **Colores en consola** (rojo, verde, amarillo, azul, cyan)
- 📊 **Barra de progreso** de 6 pasos
- ✅ **Validación automática** de requisitos
- 🔍 **Verificación de archivos** de configuración
- 📋 **Conteo de keywords** disponibles
- 📊 **Resumen final** con estado de progress.txt

### run_loop.sh
- 🎨 **Banner visual profesional**
- 📊 **Barra de progreso Unicode** (█ ░)
- 🔢 **Contador de artículos** disponibles
- ✅ **Validación de entrada** del usuario
- ⏱️ **Medición de tiempos** (total y promedio)
- 📊 **Estadísticas detalladas** (exitosos/fallidos)
- 🛑 **Control de errores** con opción de continuar

---

## Próximos Pasos

1. **Prueba inicial:**
   ```bash
   ./scripts/run_task.sh
   ```
   Genera 1 artículo para verificar funcionamiento

2. **Revisión de calidad:**
   - Verifica el contenido en `content/`
   - Comprueba que cumple estándares SEO
   - Valida enlaces internos (si existen otros artículos)

3. **Ajustes (si es necesario):**
   - Refina `docs/brand_context.md`
   - Ajusta `docs/style_guide.md`
   - Actualiza keywords en `data/keywords.csv`

4. **Generación en volumen:**
   ```bash
   ./scripts/run_loop.sh
   ```
   Genera el volumen deseado con permisos de sesión

---

## Solución de Problemas

### Error: "claude: command not found"
**Causa:** Claude Code no está instalado

**Solución:**
```bash
npm install -g @anthropic-ai/claude-code
claude init  # Autenticar
```

---

### Error: "Permission denied"
**Causa:** Scripts no tienen permisos de ejecución

**Solución:**
```bash
chmod +x scripts/*.sh
```

---

### Error: "No hay keywords en data/keywords.csv"
**Causa:** El archivo CSV está vacío o solo tiene encabezados

**Solución:**
1. Abre `data/keywords.csv`
2. Añade keywords con formato:
   ```csv
   keyword,search_volume,difficulty,url,intent
   ejemplo keyword,1000,30,/ejemplo-keyword,informational
   ```

---

### Error: Sistema solicita permisos en cada iteración del bucle
**Causa:** No se concedieron permisos al inicio de `run_loop.sh`

**Solución:**
- Al ejecutar `run_loop.sh`, responde "s" (sí) cuando solicita permisos
- Esto concede autorización para toda la sesión

---

### Contenido generado no cumple estándares
**Causa:** Configuración de marca incompleta

**Solución:**
1. Completa `docs/brand_context.md` con toda la información
2. Revisa `docs/style_guide.md` y personaliza el tono
3. Ejecuta nuevamente para ver mejoras

---

### Barras de progreso no se muestran correctamente
**Causa:** Terminal no soporta colores ANSI

**Solución:**
- Usa una terminal moderna (iTerm2, Windows Terminal, Hyper)
- O ejecuta con: `TERM=xterm-256color ./scripts/run_loop.sh`

---

## Recursos Adicionales

| Documento | Descripción |
|-----------|-------------|
| `docs/permissions_system.md` | Sistema de permisos completo |
| `PROCESO_EJECUCION_RALPH.md` | Flujo detallado del sistema |
| `docs/system_instructions.md` | Instrucciones del agente Claude |
| `estrategia_seo.md` | Estrategia de contenido SEO |

---

**Sistema Ralph SEO Cluster - Listo para personalización** 🚀
