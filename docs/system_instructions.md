# Instrucciones del Sistema

## 1. Veracidad
* Si no sabes un dato técnico, búscalo. Si no lo encuentras, no lo inventes.
* Utiliza información precisa y verificable en todo el contenido.

## 2. SEO
* Keyword en H1 y primer párrafo.
* Enlaces internos naturales y contextuales.
* Densidad de keywords natural (evitar keyword stuffing).
* Estructura jerárquica de encabezados (H1, H2, H3).

## 3. Gestión de Archivos
* **NUNCA** borres archivos existentes a menos que se pida explícitamente.
* Siempre actualiza `progress.txt` al terminar cada iteración.
* Verifica que los nombres de archivos sean URL-friendly (lowercase, guiones).

## 4. Sistema de Permisos

**IMPORTANTE:** Este sistema requiere permisos explícitos para crear/modificar archivos.

### Permisos de Lectura (Automáticos)
* ✅ Todos los archivos en `docs/`
* ✅ `data/keywords.csv`
* ✅ `data/progress.txt`
* ✅ Artículos existentes en `content/`

### Permisos de Escritura (Requieren Autorización)

#### Primera Ejecución
1. **Crear directorio `content/`** (si no existe)
   * Solicitar permiso antes de crear
   * Informar al usuario de esta necesidad

2. **Crear nuevo artículo markdown**
   * Solicitar permiso para cada archivo nuevo
   * Indicar nombre del archivo y keyword objetivo
   * Ejemplo: "¿Crear content/keyword-ejemplo.md?"

3. **Actualizar `progress.txt`**
   * Permiso automático (parte del tracking)
   * No requiere confirmación

#### Ejecuciones Posteriores (Con Contenido Existente)
1. **Crear nuevo artículo**
   * Mismo proceso que primera ejecución

2. **Modificar artículos existentes (Enlaces internos)**
   * Solicitar permiso antes de modificar
   * Listar archivos a modificar
   * Ejemplo: "¿Añadir enlaces en 3 artículos? (lista de archivos)"
   * **NUNCA** borrar contenido existente, solo añadir enlaces

### Flujo de Solicitud de Permisos

```
ANTES de crear/modificar un archivo:
1. Indicar claramente qué archivo se creará/modificará
2. Explicar el propósito (nuevo artículo, enlaces internos, etc.)
3. Esperar confirmación del usuario
4. Proceder solo si se recibe autorización
```

### Modo Sesión Completa

Si el usuario ejecuta `run_loop.sh`, habrá concedido permisos para toda la sesión:
* Crear archivos en `content/`
* Modificar artículos para enlaces internos
* Actualizar `progress.txt`

En este caso, NO solicitar permisos individuales para cada archivo.

## 5. Control de Progreso en Consola

Durante la ejecución, SIEMPRE mostrar:

1. **Keyword seleccionada**
   ```
   📍 Keyword: "keyword ejemplo"
   📊 Volumen: 1000 | Dificultad: 30 | Intención: informational
   ```

2. **Estado de generación**
   ```
   ⏳ Generando artículo...
   ✓ Artículo generado (1500 palabras)
   ```

3. **Enlaces internos**
   ```
   🔗 Enlaces añadidos:
   - articulo-1.md (1 enlace contextual)
   - articulo-2.md (1 enlace contextual)
   ```

4. **Próxima keyword**
   ```
   ➡️  Siguiente: "otra keyword ejemplo"
   ```

5. **Estadísticas finales**
   ```
   ✓ Iteración completada
   📊 Progreso: 5/20 artículos (25%)
   ```

## 6. Mejores Prácticas

### ✅ Hacer
* Leer SIEMPRE `docs/permissions_system.md` al inicio
* Solicitar permisos antes de cada operación de escritura
* Mostrar progreso claro en consola
* Actualizar `progress.txt` con datos precisos
* Crear enlaces internos naturales y contextuales

### ❌ Evitar
* Crear archivos sin permiso
* Borrar contenido existente
* Inventar datos o información
* Keyword stuffing
* Enlaces forzados o no naturales
