Write-Host ""
Write-Host "DONE: Installation and configuration finished." -ForegroundColor Cyan
Write-Host "Use 'localhost+2.pem' and 'localhost+2-key.pem' in your project." -ForegroundColor White
Write-Host "If using Node.js, NODE_EXTRA_CA_CERTS is configured." -ForegroundColor White

# --- 7. Задържане на прозореца отворен ---
Write-Host ""
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")