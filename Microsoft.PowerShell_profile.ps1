Set-Alias -Name vim -Value nvim
Set-Alias -Name v -Value nvim

$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
$ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"

Invoke-Expression ((zoxide init powershell --cmd cd) -join "`n")
Invoke-Expression (&starship init powershell)
