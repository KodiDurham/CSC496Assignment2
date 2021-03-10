function getScore{
    
	$path = "C:\cinebench\cinebench.exe"
	$logPath = "C:\cinebench\log.txt" 
    

	Start-Process -FilePath $path -ArgumentList "g_CinebenchAllTests=true g_acceptDisclaimer=true" -RedirectStandardOutput $logPath -Wait

    #############################################################################
    # Capturing a screenshot
    #############################################################################
    $File = "C:\cinebench\cineScreenchot.bmp"
    Add-Type -AssemblyName System.Windows.Forms
    Add-type -AssemblyName System.Drawing
    # Gather Screen resolution information
    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
    $Width = $Screen.Width
    $Height = $Screen.Height
    $Left = $Screen.Left
    $Top = $Screen.Top
    # Create bitmap using the top-left and bottom-right bounds
    $bitmap = New-Object System.Drawing.Bitmap $Width, $Height
    # Create Graphics object
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)
    # Capture screen
    $graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
    # Save to file
    $bitmap.Save($File) 
    Write-Output "Screenshot saved to:"
    Write-Output $File
    
    #https://www.pdq.com/blog/capturing-screenshots-with-powershell-and-net/

	return ((Get-Content $logPath |
		Where-Object { $_ -like "CB*" -or $_ -like "*Thread Count*" }))

}

ForEach-Object{getScore} | Set-Content  C:\cinebench\output.txt
# https://gist.github.com/jsmcnair/d852258509e4c75751ffebf35e9947a5
