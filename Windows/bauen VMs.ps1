# Die Namen virtueller Maschinen
##################################################
#                "MitarbeiterPC1"                # - 1
#                "MitarbeiterPC2"                # - 2
#                "KundePC1"                      # - 3
#                "KundePC2"                      # - 4
#                "AC/DC"                         # - 5
#                "VPN-Server"                    # - 6
#                "Sophos-XGS"                    # - 7

# Laden Sie das Hyper-V-Verwaltungsmodul (falls nicht geladen)
Import-Module Hyper-V

# Definieren Sie den Weg zum Ordner, in dem VHD -Dateien gespeichert werden
$VMFolderPath = "D:\VMs"

#Schritt 1
#Erstellen von virtuellen Maschinen
.{
    New-VM -Name "MitarbeiterPC1" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\MitarbeiterPC1.vhdx" -NewVHDSizeBytes 50GB -Generation 2
    New-VM -Name "MitarbeiterPC2" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\MitarbeiterPC2.vhdx" -NewVHDSizeBytes 50GB -Generation 2
    New-VM -Name "KundePC1" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\KundePC1.vhdx" -NewVHDSizeBytes 50GB -Generation 2
    New-VM -Name "KundePC2" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\KundePC2.vhdx" -NewVHDSizeBytes 50GB -Generation 2
    New-VM -Name "AC/DC" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\AC/DC.vhdx" -NewVHDSizeBytes 50GB -Generation 2
    New-VM -Name "VPN-Server" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\VPN-Server.vhdx" -NewVHDSizeBytes 50GB -Generation 2
    New-VM -Name "Sophos-XGS" -MemoryStartupBytes 4GB -NewVHDPath "$VMFolderPath\Sophos-XGS.vhdx" -NewVHDSizeBytes 50GB -Generation 2
}
#Schritt 2
#DVD -Treiber hinzufügen
.{
    Add-VMDvdDrive -VMName "MitarbeiterPC1"
    Add-VMDvdDrive -VMName "MitarbeiterPC2"
    Add-VMDvdDrive -VMName "KundePC1"
    Add-VMDvdDrive -VMName "KundePC2"
    Add-VMDvdDrive -VMName "AC/DC"
    Add-VMDvdDrive -VMName "VPN-Server"
    Add-VMDvdDrive -VMName "Sophos-XGS"
}
#Schritt 3
#Setting ISO in einer bereits vorhandenen virtuellen Maschine
.{
    Get-VMDvdDrive -VMName "MitarbeiterPC1" | Set-VmDvdDrive -Path "D:\ISOs\W10X64.PRO.ENU.JUNE.2017.iso"
    Get-VMDvdDrive -VMName "MitarbeiterPC2" | Set-VmDvdDrive -Path "D:\ISOs\W10X64.PRO.ENU.JUNE.2017.iso"
    Get-VMDvdDrive -VMName "KundePC1" | Set-VmDvdDrive -Path "D:\ISOs\W10X64.PRO.ENU.JUNE.2017.iso"
    Get-VMDvdDrive -VMName "KundePC2" | Set-VmDvdDrive -Path "D:\ISOs\W10X64.PRO.ENU.JUNE.2017.iso"
    Get-VMDvdDrive -VMName "AC/DC" | Set-VmDvdDrive -Path "D:\ISOs\de-de_windows_server_version_2022_updated_sep_2021_x64_dvd_ec89c66c.iso"
    Get-VMDvdDrive -VMName "VPN-Server" | Set-VmDvdDrive -Path "D:\ISOs\ubuntu-20.04.5-live-server-amd64.iso"
    Get-VMDvdDrive -VMName "Sophos-XGS" | Set-VmDvdDrive -Path "D:\ISOs\SW-19.0.1_MR-1-365.iso"
}
#Schritt 4
#Virtual Switch
.{
    New-VMSwitch -Name "DMZ" -SwitchType Private
    New-VMSwitch -Name "Unternehmen" -SwitchType Private
    New-VMSwitch -Name "WAN" -NetAdapterName "Wi-Fi" -AllowManagementOS $true -Notes "External switch for WAN connectivity"
}
#Schritt 5
#Add und setzen Sie einen Internet -Adapter
.{
    Add-VMNetworkAdapter -VMName "MitarbeiterPC1" -VMNetworkAdapterName "Unternehmen Netzwerk" -SwitchName "Unternehmen"
    Add-VMNetworkAdapter -VMName "MitarbeiterPC2" -VMNetworkAdapterName "Unternehmen Netzwerk" -SwitchName "Unternehmen"
    Add-VMNetworkAdapter -VMName "KundePC1" -VMNetworkAdapterName "Internet Adapter" -SwitchName "WAN"
    Add-VMNetworkAdapter -VMName "KundePC2" -VMNetworkAdapterName "Internet Adapter" -SwitchName "WAN"
    Add-VMNetworkAdapter -VMName "AC/DC" -VMNetworkAdapterName "Unternehmen Netzwerk" -SwitchName "Unternehmen"
    Add-VMNetworkAdapter -VMName "VPN-Server" -VMNetworkAdapterName "Internet Adapter" -SwitchName "WAN"
    Add-VMNetworkAdapter -VMName "VPN-Server" -VMNetworkAdapterName "DMZ Zone" -SwitchName "DMZ"
    Add-VMNetworkAdapter -VMName "Sophos-XGS" -VMNetworkAdapterName "Unternehmen Netzwerk" -SwitchName "Unternehmen"
    Add-VMNetworkAdapter -VMName "Sophos-XGS" -VMNetworkAdapterName "Internet Adapter" -SwitchName "WAN"
    Add-VMNetworkAdapter -VMName "Sophos-XGS" -VMNetworkAdapterName "DMZ Zone" -SwitchName "DMZ"
    Add-VMNetworkAdapter -VMName "Sophos-XGS" -Name "Network Adapter"
}
