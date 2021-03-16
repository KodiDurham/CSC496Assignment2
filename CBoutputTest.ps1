"Testing output.txt to see if they are numbers"

$count = (Get-Content output.txt).Length


for ($i = 0; $i -lt $count; $i++) {
    $temp = (Get-Content output.txt | Select -Index $i) -replace '\D+(\d+)','$1'
    if($temp -match "^\d+$" -and $temp -match "" ){
        "line "+ ($i+1) + ": True"
    }else{
        "line "+ ($i+1) + ": False"
    }
}


Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');