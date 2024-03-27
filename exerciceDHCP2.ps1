#========================================#
#                           	         #
# NOM : créerEtendueDHCP                 #
# AUTEUR : TERPREAU Maximilien           #
# DATE : 27 mars 2024 à 11h15            #
#                           	         #
#========================================#

<# Création d'une étendue avec interface graphique #>

#On active VisualBasic
Add-Type -AssemblyName Microsoft.VisualBasic

[Microsoft.VisualBasic.Interaction]::MsgBox("Voici le nom du serveur $env:computername Information", "OKOnly")

[string]$etendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("Quelle sera l'adresse de sous-réseaux?")
try {
    $etendueExisteDHCP = Get-DhcpServerv4Scope -ComputerName "ServeurPrimaire.local.edimbourg.cub.sioplc.fr" -ScopeId $etendueDHCP -ErrorAction Stop
    $message = ""
        foreach ($prop in $resultat | Get-Member -MemberType Properties) 
        {
            $message += "$($prop.Name): $($resultat.$($prop.Name))`n"
        }
    [Microsoft.VisualBasic.Interaction]::MsgBox($message, "Information", "Informations de l'étendue existante")
    }
catch {
    [Microsoft.VisualBasic.Interaction]::MsgBox("Il y a une erreur, c'est sûrement le fait que l'étendue n'existe pas, je vais la créer")
    [string]$nomEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("Quel sera le nom de l'étendue DHCP ?")
    [string]$debutEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("Le début de l'étendue ?")
    [string]$finEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("La fin de l'étendue ?")
    [string]$masqueEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("Le masque de sous-réseaux ?")
    [string]$routerEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("La passerelle ?")
    [string]$dnsEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("Le nom de domaine ?")
    [string]$serveurDNSEtendueDHCP = [Microsoft.VisualBasic.Interaction]::InputBox("Le serveur de domaine (Adresse IP) ?")
    [string]$scopeId = [Microsoft.VisualBasic.Interaction]::InputBox("Le ScopeId ?")
    $nouvelleEtendueDHCP = Add-DhcpServerv4Scope -Name $nomEtendueDHCP -StartRange $debutEtendueDHCP -EndRange $finEtendueDHCP -SubnetMask $masqueEtendueDHCP
    Set-DhcpServerv4OptionValue -ComputerName $serveurDNSEtendueDHCP -Router $routerEtendueDHCP -DnsDomain $dnsEtendueDHCP -DnsServer $serveurDNSEtendueDHCP -ScopeId $scopeId
    $nouvelleEtendueDHCP = Get-DhcpServerv4Scope -ComputerName "ServeurPrimaire.local.edimbourg.cub.sioplc.fr" -ScopeId $scopeId
    $message = ""
        foreach ($prop in $resultat | Get-Member -MemberType Properties) 
        {
            $message += "$($prop.Name): $($resultat.$($prop.Name))`n"
        }
    [Microsoft.VisualBasic.Interaction]::MsgBox($message, "Information", "Informations de la nouvelle étendue")
    }