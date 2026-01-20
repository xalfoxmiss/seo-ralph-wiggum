# ESTRATEGIA DE EJECUCIÓN

1. **Ingesta:** Lee toda la carpeta `docs/` y el archivo `data/keywords.csv`.
2. **Selección:** Escoge la siguiente keyword de alto volumen no realizada.
3. **Creación:** Genera el artículo en `/content`.
4. **Conexión:**
   - Lee archivos existentes.
   - Añade enlaces DESDE el nuevo HACIA los antiguos.
   - **IMPORTANTE:** Edita un artículo antiguo para enlazar al nuevo.
5. **Cierre:** Actualiza el archivo `data/progress.txt` con el progreso.
