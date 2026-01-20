# SEO Ralph Cluster - Guía de Ejecución

## Cómo Ejecutar el Sistema

### Configuración Inicial

1. **Preparar archivos de configuración:**
   - Edita `docs/brand_context.md` con la información de tu marca
   - Edita `data/keywords.csv` con tus keywords objetivo
   - Revisa `docs/style_guide.md` para ajustar el estilo de contenido

2. **Verificar permisos:**
   ```bash
   chmod +x scripts/*.sh
   ```

### Ejecución del Sistema

#### Opción 1: Ejecución Manual (Recomendado para pruebas)

```bash
# Linux/Mac
./scripts/run_task.sh

# Windows
claude -p "Genera el siguiente artículo SEO..."
```

#### Opción 2: Ejecución Automática en Bucle

```bash
# Linux/Mac
./scripts/run_loop.sh
# Ingresa el número de artículos a generar cuando se solicite

# Windows
./ralph_start.bat
# Ingresa el número de artículos a generar
```

## Sistema de Verificación

Antes de ejecutar en producción, verifica que:

- [ ] Claude Code está instalado y autenticado
- [ ] Scripts de ejecución tienen permisos correctos
- [ ] Archivos de configuración están personalizados
- [ ] Directorio `content/` existe y es escribible
- [ ] El archivo `progress.txt` está inicializado

## Monitoreo del Progreso

El sistema registra automáticamente:
- Número de artículos generados
- Última keyword procesada
- Próxima keyword en cola
- Timestamp de última ejecución

Revisa `data/progress.txt` para ver el estado actual.

## Próximos Pasos

1. Ejecuta una prueba con 1-2 artículos para verificar el funcionamiento
2. Revisa el contenido generado en `content/`
3. Ajusta la configuración si es necesario
4. Ejecuta el bucle completo para generar el volumen deseado

## Solución de Problemas

**Error: "claude: command not found"**
- Instala Claude Code: `npm install -g @anthropic-ai/claude-code`
- Ejecuta: `claude init` para autenticar

**Error: "Permission denied"**
- Ejecuta: `chmod +x scripts/*.sh`

**Contenido no se genera:**
- Verifica que `data/keywords.csv` tiene datos
- Revisa que `docs/brand_context.md` está configurado
- Comprueba los logs de ejecución

---

**Sistema Ralph SEO Cluster - Listo para personalización** 🚀
