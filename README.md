# 🕵️ Ralph SEO Cluster (Pro Edition)

> **"Me fail English? That's unpossible!"** — *Ralph Wiggum*

Sistema de automatización de contenidos SEO programático utilizando **Claude Code** como agente autónomo.

## 🧠 Arquitectura del Motor (¿Cómo funciona?)

Este sistema no es un script de Python o Node aislado. Funciona como una **orquestación de shell scripts** que invocan la herramienta CLI de Anthropic.

1.  **El Detonador (`run_loop.sh`):** Inicia un bucle `for` simple en Bash.
2.  **El Operario (`run_task.sh`):**
    * Ejecuta el comando: `claude -p "PROMPT..."`
    * Esto conecta tu terminal local con la **API de Anthropic** (Modelo Claude 3.5 Sonnet).
    * Le inyecta el contexto de la carpeta `/docs` y `/data`.
3.  **La Acción (Tool Use):**
    * Claude devuelve instrucciones para crear archivos (`write_file`) o ejecutar comandos (`bash`).
    * Tu ordenador ejecuta esas instrucciones (gracias a los permisos en `.claude/settings.local.json`).

## 📋 Requisitos Previos (CRÍTICO)

Para que el "motor" arranque, necesitas instalar esto en tu máquina:

1.  **Node.js (v18 o superior):**
    * Comprobar: `node -v`
    * Instalar: [nodejs.org](https://nodejs.org/)
2.  **Claude Code (La herramienta oficial):**
    * Instalar: `npm install -g @anthropic-ai/claude-code`
    * **Autenticar (Vital):** Ejecuta `claude init` y sigue los pasos para loguearte.
3.  **Git Configurado:**
    * El agente hará commits. Necesita saber quién eres.
    * Ejecuta:
        ```bash
        git config --global user.name "Tu Nombre"
        git config --global user.email "tu@email.com"
        ```

## 🚀 Uso Rápido

1.  **Preparación:**
    ```bash
    chmod +x scripts/*.sh
    ```
2.  **Personalización:**
    * Edita `docs/brand_context.md` (Tu marca).
    * Edita `data/keywords.csv` (Tus temas).
3.  **Ejecución:**
    ```bash
    ./scripts/run_loop.sh
    ```

## 📂 Estructura de Archivos

* `docs/`: **Gobernanza.** El agente lee esto ANTES de escribir nada.
* `data/`: **Input.** CSV de keywords y tracker de progreso.
* `content/`: **Output.** Aquí aparecen los .md mágicamente.
* `scripts/`: **Lógica.** Los scripts que conectan con la API.

## ⚠️ Control de Costes
Este sistema consume tokens de entrada (leyendo docs) y salida (escribiendo artículos).
* Monitorea tu uso ejecutando `/cost` dentro de una sesión interactiva de Claude.
