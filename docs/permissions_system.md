# Sistema de Permisos - SEO Ralph Cluster

## Descripción General

El sistema Ralph opera en **modo completamente automático** usando el flag `--permission-mode bypassPermissions` de Claude Code. Esto significa que **NO se solicitan confirmaciones** durante la ejecución.

**IMPORTANTE: El sistema funciona de forma AUTOMÁTICA. No requiere confirmaciones manuales ni permisos interactivos.**

---

## 🚀 Modo Automático

### Cómo Funciona

Los scripts `run_task.sh` y `run_loop.sh` ejecutan Claude Code con el flag:
```bash
claude -p --permission-mode bypassPermissions "..."
```

Esto configura el sistema para:
- ✅ Crear archivos automáticamente sin preguntar
- ✅ Modificar archivos existentes sin confirmación
- ✅ Actualizar progress.txt automáticamente
- ✅ Añadir enlaces internos sin solicitudes

### Ejecución

```bash
# Para generar un solo artículo
./scripts/run_task.sh

# Para generar múltiples artículos en bucle
./scripts/run_loop.sh
```

**Lo que sucede automáticamente:**

1. ✅ Los scripts verifican/crean el directorio `content/`
2. ✅ Configuran permisos en `data/` con `chmod 755 data`
3. ✅ Claude ejecuta con permisos pre-concedidos
4. ✅ El sistema genera contenido sin pedir confirmaciones
5. ✅ Se actualizan automáticamente todos los archivos necesarios

**Ya NO necesitas:**
- ❌ Responder "s/n" para crear archivos
- ❌ Conceder permisos manualmente en cada iteración
- ❌ Supervisar el proceso constantemente

---

## Operaciones Automáticas

### 1. Lectura (Siempre Permitida)

El sistema lee automáticamente:

**Archivos de Configuración:**
- `docs/brand_context.md` - Contexto de marca y tono
- `docs/style_guide.md` - Guía de estilo
- `docs/system_instructions.md` - Instrucciones del sistema
- `estrategia_seo.md` - Estrategia SEO

**Archivos de Datos:**
- `data/keywords.csv` - Keywords objetivo con métricas
- `data/progress.txt` - Estado actual del progreso

**Contenido Existente:**
- `content/*.md` - Artículos previamente generados

---

### 2. Escritura (Automática)

El sistema EJECUTA automáticamente las siguientes operaciones:

#### A. Creación de Archivos de Contenido

```bash
# Crea archivos markdown automáticamente
content/nombre-keyword-url-friendly.md
```

**Cuándo:** En cada iteración de generación de artículos

**Formato del nombre:**
- Basado en el campo 'URL' del CSV
- Minúsculas, guiones, sin caracteres especiales
- Ejemplo: URL `/categoria/ejemplo-seo/` → archivo `ejemplo-seo.md`

**Riesgo:** ⚠️ BAJO - El sistema verifica que el archivo no exista antes de crear

---

#### B. Modificación de Artículos Existentes

```bash
# Añade enlaces internos en artículos relacionados
content/articulo-existente.md
```

**Cuándo:** Al generar nuevos artículos que se relacionan con existentes

**Operación:**
- Identifica artículos relacionados por keywords/temática
- Añade enlaces contextuales naturales
- **NUNCA borra contenido existente**

**Riesgo:** ⚠️ MEDIO - Solo añade enlaces, no elimina contenido

---

#### C. Actualización de Progreso

```bash
# Actualiza el tracking del sistema
data/progress.txt
```

**Cuándo:** Al finalizar cada iteración

**Operación:**
- Incrementa contador de artículos generados
- Registra última keyword procesada
- Actualiza timestamp

**Riesgo:** ⚠️ BAJO - Formato estructurado preservado

---

## Seguridad y Protecciones

### Protecciones Implementadas

El sistema tiene las siguientes protecciones automáticas:

1. **No sobrescribe archivos existentes**
   - Verifica que el archivo no exista antes de crear
   - Si existe, el sistema lo informa y no lo sobrescribe

2. **No borra contenido**
   - Al modificar artículos existentes, solo AÑADE enlaces
   - El contenido original se preserva intacto

3. **Scope limitado**
   - Solo opera en `content/` y `data/`
   - No modifica archivos de configuración en `docs/`
   - No modifica scripts

4. **Nombres URL-friendly**
   - Valida que los nombres de archivo sean correctos
   - Usa el campo URL del CSV como fuente

### Mejores Prácticas de Seguridad

#### ✅ Recomendado

1. **Primera ejecución controlada**
   - Genera 1 artículo primero con `./scripts/run_task.sh`
   - Revisa la calidad antes de ejecutar bucle masivo

2. **Backups regulares**
   - Haz copia de `content/` antes de generación masiva
   - Usa git para trackear cambios

3. **Monitoreo de progreso**
   - Verifica `data/progress.txt` después de cada sesión
   - Revisa los artículos generados periódicamente

4. **Keywords válidas**
   - Asegúrate de que `data/keywords.csv` tenga datos reales
   - Evita keywords duplicadas o inválidas

#### ❌ Evitar

1. **No ejecutar sin backups en producción**
   - Siempre ten respaldo del contenido existente

2. **No ignorar errores**
   - Si el script falla, revisa los logs antes de continuar

3. **No modificar archivos durante ejecución**
   - Deja que el sistema complete antes de editar manualmente

---

## Tabla Resumen de Operaciones

| Operación | Directorio/Archivo | Modo | Confirmación | Riesgo |
|-----------|-------------------|------|--------------|--------|
| Leer | `docs/*.md` | Automático | NO | Ninguno |
| Leer | `estrategia_seo.md` | Automático | NO | Ninguno |
| Leer | `data/keywords.csv` | Automático | NO | Ninguno |
| Leer | `data/progress.txt` | Automático | NO | Ninguno |
| Leer | `content/*.md` | Automático | NO | Ninguno |
| Crear | `content/` (directorio) | Automático | NO | Bajo |
| Crear | `content/*.md` | Automático | NO | Bajo |
| Modificar | `content/*.md` | Automático | NO | Medio |
| Modificar | `data/progress.txt` | Automático | NO | Bajo |

---

## Solución de Problemas

### Problema: "Permission denied" al crear archivos

**Causa:** Permisos del sistema operativo insuficientes

**Solución:**
```bash
# Verificar permisos de escritura
ls -la content/
ls -la data/

# Otorgar permisos si es necesario
chmod 755 content/
chmod 755 data/
chmod 644 data/progress.txt
```

---

### Problema: Archivos no se crean

**Causa:** Error en el script o configuración incorrecta

**Solución:**
1. Verifica que `content/` existe: `ls -la content/`
2. Confirma que `data/progress.txt` es escribible: `ls -la data/progress.txt`
3. Revisa que Claude Code esté autenticado: `claude --version`
4. Ejecuta con debug: Revisa los logs del script

---

### Problema: El sistema pregunta por permisos

**Causa:** El flag `--permission-mode bypassPermissions` no está siendo usado

**Solución:**
1. Verifica que los scripts tengan el flag actualizado
2. Revisa el contenido de `scripts/run_task.sh` línea ~99
3. Debe contener: `claude -p --permission-mode bypassPermissions`

---

### Problema: Contenido generado de baja calidad

**Causa:** Configuración de marca incompleta

**Solución:**
1. Completa `docs/brand_context.md` con información real
2. Revisa `docs/style_guide.md` y personaliza el estilo
3. Actualiza `data/keywords.csv` con keywords reales
4. Ejecuta nuevamente para ver mejoras

---

## Conclusión

El sistema Ralph opera en **modo completamente automático**:

- ✅ **Sin confirmaciones**: No solicita permisos durante la ejecución
- ✅ **Rápido**: Genera contenido sin interrupciones
- ✅ **Seguro**: Protecciones integradas contra sobrescritura y pérdida de datos
- ✅ **Eficiente**: Ideal para generación masiva de contenido SEO

Este diseño permite automatización completa mientras mantiene protecciones esenciales.
