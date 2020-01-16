#------------------------------------------------------------------------------------------
# コンフィグファイルの読み込み
#------------------------------------------------------------------------------------------
$NTNXConfig = $args[0]
Get-ChildItem $NTNXConfig | Out-Null
if($? -eq $false){"コンフィグファイルを指定してください。"; exit 1}
. $NTNXConfig

<#------------------------------------------------------------------------------------------#>
# VMリスト生成セクション : VM List Generator
<#------------------------------------------------------------------------------------------#>
# Connect to Nutanix Cluster
# Nutanixクラスターへ接続
Add-PSSnapin NutanixCmdletsPSSnapin
$secure = ConvertTo-SecureString $NTNXPwd -AsPlainText -Force
Connect-NTNXCluster -Server $NTNXIP.ToString() -UserName $NTNXUser.ToString() -Password $secure -AcceptInvalidSSLCerts -Force

# Create All VMs List included Nutanix Cluster
$vms = @(get-ntnxvm) 
 
$VMList=@()
foreach ($vm in $vms){                        
    $VMArray=@{
        "VM Name" = $vm.vmName
        "Power ON/OFF" = $vm.powerstate
        "Node" = $vm.hostName
        "IP Address" = $vm.ipAddresses -join " "
        "vCPU" = $vm.numVCpus
        "RAM(GB)" = $vm.memoryCapacityInBytes / 1GB
        "DISK(GB)" = $vm.diskCapacityInBytes / 1GB
    }
    $Buffer = New-Object PSCustomObject -Property $VMArray
    $VMList += $Buffer
}

#Write-Output $Buffer
#Write-Output $Report
$OutputFileName = $RepLocate + "\VMList-" + (Get-Date).ToString("yyyyMMdd-HHmmss") +".csv"
$VMList | Export-Csv $OutputFileName -Encoding Default -NoTypeInformation
Disconnect-NTNXCluster -Servers $NTNXIP
