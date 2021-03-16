function getScore{
    
	#$path = "C:\cinebench\cinebench.exe"
    $path = where cinebench.exe
	#$logPath = "C:\cinebench\log.txt" 
    $logPath= $path.Parent.FullName +"log.txt"

	Start-Process -FilePath $path -ArgumentList "g_CinebenchAllTests=true g_acceptDisclaimer=true" -RedirectStandardOutput $logPath -Wait

	return ((Get-Content $logPath |
		Where-Object { $_ -like "CB*" -or $_ -like "*Thread Count*" }) -split " ")[13,15,18]
}


ForEach-Object{getScore} | Set-Content  temp.txt
# https://gist.github.com/jsmcnair/d852258509e4c75751ffebf35e9947a5

Set-Content output.txt ("Number of Cores in This Machine: " + (Get-Content temp.txt | Select -Index 0))
Add-Content output.txt ("Cinebench R23 Multi core Score: " + (Get-Content temp.txt | Select -Index 1))
Add-Content output.txt ("Cinebench R23 Single core Score: " + (Get-Content temp.txt | Select -Index 2))
Add-Content output.txt ("Cinebench R23 Estimated Single Core: " + ((Get-Content temp.txt | Select -Index 1)/(Get-Content temp.txt | Select -Index 0)))

Remove-Item temp.txt
