@echo OFF
setlocal EnableDelayedExpansion

Powershell.exe -executionpolicy remotesigned -File  .\upgrade-www-module.ps1

pause
exit