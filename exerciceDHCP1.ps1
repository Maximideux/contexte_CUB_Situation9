#========================================#
#                           	         #
# NOM : créerEtendueDHCP                 #
# AUTEUR : TERPREAU Maximilien           #
# DATE : 20 mars 2024 à 11h15            #
#                           	         #
#========================================#

<# Création d'une étendue #>
Write-Host "Voici le nom du serveur $env:computername"

[string]$etendueDHCP = Read-Host "Quelle sera l'adresse de sous-réseaux?"
try {
    $etendueExisteDHCP = Get-DhcpServerv4Scope -ComputerName "ServeurPrimaire.local.edimbourg.cub.sioplc.fr" -ScopeId $etendueDHCP -ErrorAction Stop
    }
catch {
    Write-Host "Il y a une erreur, c'est sûrement le fait que l'étendue n'existe pas, je vais la créer"
    [string]$nomEtendueDHCP = Read-Host "Quel sera le nom de l'étendue DHCP ?"
    [string]$debutEtendueDHCP = Read-Host "Le début de l'étendue ?"
    [string]$finEtendueDHCP = Read-Host "La fin de l'étendue ?"
    [string]$masqueEtendueDHCP = Read-Host "Le masque de sous-réseaux ?"
    [string]$routerEtendueDHCP = Read-Host "La passerelle ?"
    [string]$dnsEtendueDHCP = Read-Host "Le nom de domaine ?"
    [string]$serveurDNSEtendueDHCP = Read-Host "Le serveur de domaine (Adresse IP) ?"
    $nouvelleEtendueDHCP = Add-DhcpServerv4Scope -Name $nomEtendueDHCP -StartRange $debutEtendueDHCP -EndRange $finEtendueDHCP -SubnetMask $masqueEtendueDHCP
    Set-DhcpServerv4OptionValue -ComputerName $serveurDNSEtendueDHCP -Router $routerEtendueDHCP -DnsDomain $dnsEtendueDHCP -DnsServer $serveurDNSEtendueDHCP
    }
$nouvelleEtendueDHCP
$etendueExisteDHCP