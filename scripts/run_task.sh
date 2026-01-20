#!/bin/bash
# Llama a Claude inyectando el contexto de documentación
claude -p "Estás en modo agente autónomo (Ralph).
1. LEE PRIMERO: docs/brand_context.md, docs/style_guide.md y docs/system_instructions.md.
2. LEE LUEGO: estrategia_seo.md.
3. EJECUTA: Una iteración completa de creación de contenido y actualización de enlaces internos.
4. FINALIZA: Con git commit."
