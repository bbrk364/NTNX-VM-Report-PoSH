<#------------------------------------------------------------------------------------------#>
# 変数の設定 / Variables Setting
#   $NTNXIP     : クラスターIP
#   $NTNXUser   : ユーザー名
#   $NTNXPwd    : パスワード
#   $RepLocate  : 出力先の設定 "C:\<任意のディレクトリを入力>" ※作成済みであること
<#------------------------------------------------------------------------------------------#>
$NTNXIP     =   "192.168.1.1"
$NTNXUser   =   "admin"
$NTNXPwd    =   "nutanix/4u"
$RepLocate  =   "C:\NTNX_Report"

<#------------------------------------------------------------------------------------------#>
# VMリスト生成セクション : VM List Generator
<#------------------------------------------------------------------------------------------#>
# Connect to Nutanix Cluster
# Nutanixクラスターへ接続
Add-PSSnapin NutanixCmdletsPSSnapin
$secure = ConvertTo-SecureString $NTNXPwd -AsPlainText -Force
Connect-NTNXCluster -Server $NTNXIP.ToString() -UserName $NTNXUser.ToString() -Password $secure -AcceptInvalidSSLCerts 

# Create All VMs List included Nutanix Cluster
$vms = @(get-ntnxvm) 
 
$VMList=@()
foreach ($vm in $vms){                        
    $VMArray=@{
        "VM Name" = $vm.vmName
        "Power ON/OFF" = $vm.powerstate
        "Node" = $vm.hostName
        "IP Address" = $vm.ipAddresses
        "vCPU" = $vm.numVCpus
        "RAM(GB)" = $vm.memoryCapacityInBytes
        "DISK(GB)" = $vm.diskCapacityInBytes
    }
    $Buffer = New-Object PSCustomObject -Property $VMArray
    $VMList += $Buffer
}

#Write-Output $Buffer
#Write-Output $Report
$OutputFileName = $RepLocate + "\VMList-" + (Get-Date).ToString("yyyyMMdd-HHmmss") +".csv"
$Report | Export-Csv $OutputFileName -Encoding Default
Disconnect-NTNXCluster -Servers $NTNXIP
