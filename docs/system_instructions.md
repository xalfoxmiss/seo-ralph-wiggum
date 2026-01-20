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

## 4. Sistema de Operaciones de Archivos

**IMPORTANTE:** Este sistema opera en modo automático con permisos pre-configurados.

### Operaciones de Lectura (Siempre Permitidas)
* ✅ Todos los archivos en `docs/`
* ✅ `data/keywords.csv`
* ✅ `data/progress.txt`
* ✅ Artículos existentes en `content/`

### Operaciones de Escritura (Automáticas)

El sistema ejecuta con el flag `--permission-mode bypassPermissions`, lo que significa:

1. **Crear nuevo artículo markdown**
   * PROCEDE DIRECTAMENTE sin solicitar confirmación
   * Usa el nombre del archivo basado en el campo URL del CSV
   * Formato: `content/keyword-url-friendly.md`
   * Ejemplo: Si URL es `/guia-seo/`, crea `content/guia-seo.md`

2. **Actualizar `progress.txt`**
   * ACTUALIZA AUTOMÁTICAMENTE después de cada iteración
   * Registra el progreso y la última keyword procesada

3. **Modificar artículos existentes (Enlaces internos)**
   * AÑADE ENLACES AUTOMÁTICAMENTE en artículos relacionados
   * **NUNCA** borres contenido existente, solo añade enlaces
   * Identifica artículos relacionados por temática/keywords

### Flujo de Ejecución Automática

```
1. Leer archivos de configuración
2. Identificar siguiente keyword a procesar
3. Generar contenido completo (2000-2500 palabras)
4. CREAR archivo .md inmediatamente usando Write tool
5. AÑADIR enlaces internos si existen artículos relacionados
6. ACTUALIZAR progress.txt con nuevo estado
```

**NO solicites confirmaciones ni permisos. El sistema está configurado para operar automáticamente.**

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
* Leer SIEMPRE los archivos de configuración al inicio
* Proceder directamente con las operaciones de escritura (sin pedir permisos)
* Mostrar progreso claro en consola durante la ejecución
* Actualizar `progress.txt` con datos precisos después de cada artículo
* Crear enlaces internos naturales y contextuales
* Usar nombres de archivo URL-friendly (minúsculas, guiones)

### ❌ Evitar
* Solicitar confirmaciones o permisos (el sistema ya los tiene)
* Borrar contenido existente de archivos
* Inventar datos o información no verificable
* Keyword stuffing o sobre-optimización
* Enlaces forzados o no naturales
* Crear archivos con nombres que no coinciden con el campo URL del CSV
