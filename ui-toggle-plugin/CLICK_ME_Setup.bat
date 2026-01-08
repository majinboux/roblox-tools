@echo off
title Roblox Classic Toolbar Setup - by majinboux
color 0B

echo.
echo ============================================
echo   Roblox Studio Classic Toolbar Setup
echo   By majinboux (inspired by Mincraftmark0)
echo ============================================
echo.
echo This will configure Roblox Studio for classic toolbar.
echo.
pause

powershell -ExecutionPolicy Bypass -File "%~dp0SetupClassicToolbar.ps1"
