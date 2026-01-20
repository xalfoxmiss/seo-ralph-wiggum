# Sistema de Permisos - SEO Ralph Cluster

## Descripción General

El sistema Ralph tiene **permisos pre-configurados** para crear y modificar archivos durante el proceso de generación de contenido SEO. Los scripts `run_task.sh` y `run_loop.sh` configuran automáticamente los directorios y permisos necesarios, eliminando la necesidad de solicitudes manuales repetitivas.

**IMPORTANTE: El sistema ahora funciona de forma AUTOMÁTICA. No requiere confirmaciones manuales en cada iteración.**

---

## 🚀 Inicio Rápido - Configuración Automática

El sistema Ralph ahora se configura automáticamente al ejecutar los scripts. Simplemente ejecuta:

```bash
# Para generar un solo artículo
./scripts/run_task.sh

# Para generar múltiples artículos en bucle
./scripts/run_loop.sh
```

**Lo que sucede automáticamente:**

1. ✅ Los scripts verifican si existe el directorio `content/`
2. ✅ Si no existe, lo crean con `mkdir -p content && chmod 755 content`
3. ✅ Configuran permisos en `data/` con `chmod 755 data`
4. ✅ Claude recibe instrucciones con permisos PRE-CONCEDIDOS
5. ✅ El sistema genera contenido sin pedir confirmaciones repetitivas

**Ya no necesitas:**
- ❌ Responder "s/n" para crear directorios
- ❌ Conceder permisos manualmente en cada iteración
- ❌ Ejecutar comandos de permisos de forma manual

---

## Permisos Requeridos

### 1. Permisos de Lectura

El agente Claude necesita **acceso de lectura** a los siguientes archivos y directorios:

#### Archivos de Configuración (Obligatorios)
- `docs/brand_context.md` - Contexto de marca y tono de comunicación
- `docs/style_guide.md` - Guía de estilo para el contenido
- `docs/system_instructions.md` - Instrucciones del sistema
- `estrategia_seo.md` - Estrategia y flujo de trabajo SEO

#### Archivos de Datos (Obligatorios)
- `data/keywords.csv` - Lista de keywords objetivo con métricas
- `data/progress.txt` - Estado actual del progreso de generación

#### Contenido Existente (Opcional)
- `content/*.md` - Artículos previamente generados (para enlaces internos)

**Estado:** Estos permisos están **SIEMPRE ACTIVOS** y no requieren autorización especial.

---

### 2. Permisos de Escritura

El agente Claude requiere **autorización explícita** para las siguientes operaciones:

#### A. Creación de Directorios

```bash
# Directorio principal de contenido
content/

# Subdirectorios (si se requiere categorización)
content/categoría-1/
content/categoría-2/
```

**Cuándo se requiere:** Primera ejecución o cuando no existe el directorio `content/`.

**Riesgo:** ⚠️ BAJO - Solo crea estructura de carpetas.

---

#### B. Creación de Archivos de Contenido

```bash
# Archivos markdown de artículos
content/nombre-articulo-seo-friendly.md
content/otra-keyword-url-friendly.md
```

**Cuándo se requiere:** Cada iteración de generación de artículos.

**Riesgo:** ⚠️ MEDIO - Crea archivos nuevos, puede sobreescribir si ya existe el nombre.

**Mitigación:** El sistema verifica que no exista el archivo antes de crearlo.

---

#### C. Modificación de Archivos Existentes

```bash
# Actualización de artículos para añadir enlaces internos
content/articulo-existente.md

# Actualización de progreso
data/progress.txt
```

**Cuándo se requiere:**
- **Enlaces internos:** Al generar nuevos artículos que deben enlazarse con existentes
- **Progress tracking:** Al finalizar cada iteración

**Riesgo:** ⚠️ ALTO - Modifica contenido existente.

**Mitigación:**
- El sistema **NUNCA** borra contenido existente
- Solo añade enlaces internos contextuales
- `progress.txt` tiene formato estructurado que se preserva

---

## Comandos de Permisos Explícitos Requeridos

El sistema Ralph solicita permisos explícitos para ejecutar las siguientes operaciones:

### Comando 1: Crear archivos nuevos en `/content/`

**Operación:**
```bash
# El sistema solicita permiso para ejecutar:
Write("/home/user/seo-ralph-wiggum/content/nombre-keyword-url.md", contenido)
```

**Cuándo se solicita:**
- En cada iteración de generación de artículos
- Antes de crear cualquier archivo `.md` nuevo en `content/`

**Ejemplo de solicitud:**
```
🔐 Permiso requerido:
   Crear archivo: content/guia-seo-completa.md
   Tamaño estimado: ~2500 palabras

   ¿Autorizar creación de este archivo? (s/n)
```

**Respuesta del usuario:**
```bash
s  # Para conceder permiso
n  # Para denegar
```

---

### Comando 2: Modificar `data/progress.txt`

**Operación:**
```bash
# El sistema solicita permiso para ejecutar:
Edit("data/progress.txt", old_content, new_content)
```

**Cuándo se solicita:**
- Al finalizar cada iteración de generación de artículo
- Para actualizar el contador de progreso
- Para registrar la última keyword procesada

**Ejemplo de solicitud:**
```
🔐 Permiso requerido:
   Modificar archivo: data/progress.txt
   Operación: Actualizar progreso de 5 a 6 artículos

   ¿Autorizar modificación? (s/n)
```

**Respuesta del usuario:**
```bash
s  # Para conceder permiso
n  # Para denegar
```

**IMPORTANTE:** Esta operación es **automática** en el contexto del sistema Ralph, ya que es parte esencial del tracking. Sin embargo, el usuario debe ser consciente de que este archivo se modificará en cada iteración.

---

### Comando 3: Modificar artículos existentes (enlaces internos)

**Operación:**
```bash
# El sistema solicita permiso para ejecutar:
Edit("content/articulo-existente.md", contenido_actual, contenido_con_enlaces)
```

**Cuándo se solicita:**
- Cuando se genera un nuevo artículo y se identifican artículos relacionados
- Para añadir enlaces internos contextuales entre contenido relacionado

**Ejemplo de solicitud:**
```
🔐 Permiso requerido:
   Modificar 3 artículos existentes para añadir enlaces internos:

   1. content/seo-basico.md (añadir 1 enlace contextual)
   2. content/keywords-research.md (añadir 1 enlace contextual)
   3. content/link-building.md (añadir 1 enlace contextual)

   ¿Autorizar modificación de estos archivos? (s/n)
```

**Respuesta del usuario:**
```bash
s  # Para conceder permiso
n  # Para denegar
```

---

### ✅ Configuración Automática de Permisos (NUEVO)

El sistema ahora configura **automáticamente** todos los permisos necesarios al inicio de cada sesión:

**Al ejecutar `run_task.sh` o `run_loop.sh`:**

```bash
📋 Configuración de permisos:

  • Creando directorio content/...
    ✓ Directorio creado con permisos de escritura
  ✓ Permisos configurados en data/

✓ Permisos configurados automáticamente
  El sistema generará N artículos con permisos pre-concedidos
```

**Esto significa que el sistema:**
- ✅ Crea `content/` automáticamente si no existe
- ✅ Establece permisos `755` en `content/` y `data/`
- ✅ Genera archivos `.md` sin pedir confirmación
- ✅ Actualiza `progress.txt` automáticamente
- ✅ Añade enlaces internos sin solicitudes repetitivas

**IMPORTANTE:** Ya NO es necesario responder "s/n" en cada iteración. Todo funciona de forma automática.

---

## Flujo de Autorización de Permisos

### Primera Ejecución (Setup Inicial)

```
┌─────────────────────────────────────┐
│ 1. Verificar existencia de content/ │
└──────────────┬──────────────────────┘
               │
               ├─ NO EXISTE ──> Solicitar permiso creación
               │                       │
               │                       v
               │              ┌────────────────────┐
               │              │ Usuario concede    │
               │              │ permiso: Sí/No     │
               │              └─────────┬──────────┘
               │                        │
               │                        └─> Crear content/
               │
               └─ EXISTE ──> Continuar
                              │
                              v
┌─────────────────────────────────────────┐
│ 2. Generar primer artículo              │
└──────────────┬──────────────────────────┘
               │
               v
┌─────────────────────────────────────────┐
│ 3. Solicitar permiso: crear archivo MD  │
│    "¿Crear content/keyword-ejemplo.md?" │
└──────────────┬──────────────────────────┘
               │
               └──> Usuario concede permiso
                              │
                              v
┌─────────────────────────────────────────┐
│ 4. Generar contenido optimizado         │
└──────────────┬──────────────────────────┘
               │
               v
┌─────────────────────────────────────────┐
│ 5. Actualizar data/progress.txt         │
│    (Permiso automático)                 │
└─────────────────────────────────────────┘
```

---

### Ejecuciones Posteriores (Con Contenido Existente)

```
┌─────────────────────────────────────┐
│ 1. Leer artículos existentes        │
│    content/*.md                      │
└──────────────┬──────────────────────┘
               │
               v
┌─────────────────────────────────────────────┐
│ 2. Generar nuevo artículo                   │
└──────────────┬──────────────────────────────┘
               │
               v
┌──────────────────────────────────────────────┐
│ 3. Solicitar permiso: crear nuevo MD        │
│    "¿Crear content/nueva-keyword.md?"       │
└──────────────┬───────────────────────────────┘
               │
               └──> Usuario concede permiso
                              │
                              v
┌──────────────────────────────────────────────┐
│ 4. Identificar artículos relacionados       │
│    (basado en keywords/temática)            │
└──────────────┬───────────────────────────────┘
               │
               v
┌──────────────────────────────────────────────┐
│ 5. Solicitar permiso: modificar existentes  │
│    "¿Añadir enlaces en 3 artículos?"        │
│     - articulo-1.md                         │
│     - articulo-2.md                         │
│     - articulo-3.md                         │
└──────────────┬───────────────────────────────┘
               │
               └──> Usuario concede permiso
                              │
                              v
┌──────────────────────────────────────────────┐
│ 6. Añadir enlaces internos contextuales     │
│    (NO borra contenido existente)           │
└──────────────┬───────────────────────────────┘
               │
               v
┌──────────────────────────────────────────────┐
│ 7. Actualizar data/progress.txt             │
└──────────────────────────────────────────────┘
```

---

## Respuestas a Solicitudes de Permisos

### ✅ Conceder Permisos (Respuestas Válidas)

Cuando Claude solicita permisos, puedes responder con:

```
"Sí, procede"
"Adelante"
"Concedido"
"OK"
"Sí"
"Yes"
"Autorizado"
```

### ❌ Denegar Permisos (Respuestas Válidas)

```
"No"
"Cancelar"
"Denegar"
"Detener"
"No, espera"
```

### 🔄 Conceder Permisos Permanentes (Sesión Completa)

Si ejecutas el sistema en bucle (`run_loop.sh`) y quieres evitar confirmaciones en cada iteración:

```bash
# Al inicio de la sesión, indica:
"Concedo permisos para toda la sesión:
- Crear archivos en content/
- Modificar archivos existentes para enlaces internos
- Actualizar progress.txt
Procede con todas las iteraciones."
```

**Nota:** Esta autorización es válida **SOLO para la sesión actual** y debe renovarse en cada ejecución del sistema.

---

## Mejores Prácticas de Seguridad

### ✅ Hacer

1. **Revisar permisos en primera ejecución:** Verifica manualmente el primer artículo antes de autorizar generación masiva
2. **Backups regulares:** Haz copias de `content/` antes de ejecutar modificaciones masivas
3. **Monitorear progress.txt:** Verifica que el tracking sea correcto después de cada sesión
4. **Revisar enlaces añadidos:** Valida que los enlaces internos sean coherentes y contextuales

### ❌ Evitar

1. **No conceder permisos sin leer:** Siempre lee qué archivos se modificarán
2. **No ejecutar sin backups:** En producción, siempre ten respaldos antes de generar contenido
3. **No ignorar advertencias:** Si Claude indica que un archivo ya existe, decide conscientemente si sobreescribir
4. **No otorgar permisos de escritura fuera de content/:** El sistema NO debe modificar archivos fuera de `content/` y `data/`

---

## Tabla Resumen de Permisos

| Operación | Directorio/Archivo | Tipo | Autorización | Riesgo |
|-----------|-------------------|------|--------------|--------|
| Leer | `docs/*.md` | Lectura | Automática | Ninguno |
| Leer | `estrategia_seo.md` | Lectura | Automática | Ninguno |
| Leer | `data/keywords.csv` | Lectura | Automática | Ninguno |
| Leer | `data/progress.txt` | Lectura | Automática | Ninguno |
| Leer | `content/*.md` | Lectura | Automática | Ninguno |
| Crear | `content/` (directorio) | Escritura | **Requerida** | Bajo |
| Crear | `content/*.md` | Escritura | **Requerida** | Medio |
| Modificar | `content/*.md` (existentes) | Escritura | **Requerida** | Alto |
| Modificar | `data/progress.txt` | Escritura | Automática* | Bajo |

*Automática solo para `progress.txt` porque es parte del tracking del sistema.

---

## Solución de Problemas

### Problema: "Permission denied" al crear archivos

**Causa:** Permisos del sistema operativo insuficientes

**Solución:**
```bash
# Verificar permisos de escritura en content/
ls -la content/

# Otorgar permisos si es necesario
chmod -R u+w content/
```

---

### Problema: Claude no solicita permisos y falla

**Causa:** Configuración incorrecta o error en el flujo

**Solución:**
1. Verifica que `content/` existe: `mkdir -p content`
2. Confirma que `data/progress.txt` es escribible
3. Reinicia la sesión de Claude Code

---

### Problema: Archivos se sobrescriben sin autorización

**Causa:** Bug del sistema (no debería ocurrir)

**Solución:**
1. Detén la ejecución inmediatamente
2. Restaura desde backup
3. Reporta el issue en el repositorio del sistema

---

## Conclusión

El sistema de permisos está diseñado para:

1. **✅ Proteger contenido existente:** Nunca borra archivos sin confirmación
2. **✅ Transparencia:** Siempre informa qué archivos se crearán/modificarán
3. **✅ Flexibilidad:** Permite autorización por archivo o por sesión completa
4. **✅ Seguridad:** Requiere confirmación para operaciones de riesgo

Este sistema garantiza que mantengas control total sobre el contenido generado mientras permites automatización eficiente.
