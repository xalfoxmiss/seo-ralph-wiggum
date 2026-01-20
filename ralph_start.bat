@echo off
title Ralph SEO Automation
echo ==========================================
echo      INICIANDO PROTOCOLO RALPH (Windows)
echo ==========================================
echo.

set /p iterations="Cuantos articulos quieres generar hoy? "

for /L %%i in (1,1,%iterations%) do (
   cls
   echo ==========================================
   echo      TRABAJANDO EN ARTICULO %%i DE %iterations%
   echo ==========================================
   echo.
   
   call claude -p "Estás en modo agente autónomo (Ralph). 1. LEE PRIMERO: docs/brand_context.md, docs/style_guide.md y docs/system_instructions.md. 2. LEE LUEGO: estrategia_seo.md. 3. EJECUTA: Una iteración completa (Investigacion -> Redaccion -> Interlinking -> Guardar progreso). IMPORTANTE: No pidas confirmacion manual, procede."
   
   echo.
   echo [OK] Articulo %%i terminado. Descansando 5 segundos...
   timeout /t 5 >nul
)

echo.
echo ==========================================
echo      TRABAJO FINALIZADO
echo ==========================================
pause