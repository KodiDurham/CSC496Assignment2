$path= [String]$PSScriptRoot
$dir1 = Get-ChildItem -Name -Directory
function getOrganized{
    $dir1 | ForEach-Object{
    $curDir1=$_
    cd $_
    $dir2 = Get-ChildItem -Name -Directory
    $dir2 | ForEach-Object{
        cd $_
        $curDir2=$_
        $file = Get-Content benchmark.txt

        $fileName=$curDir1+"_"+$curDir2+"_"

        if(Test-Path -Path ($path +"\"+ $fileName + "tempCVStxtFile.txt")){

            Remove-Item -Path ($path +"\"+ $fileName + "tempCVStxtFile.txt")
            Add-Content -Path ($path +"\"+ $fileName + "tempCVStxtFile.txt") ("game`tresolution`tavg`tmin`tmax`tonepercent`tpointone")
        }else{
    

        Add-Content -Path ($path +"\"+ $fileName +"tempCVStxtFile.txt") ("game`tresolution`tavg`tmin`tmax`tonepercent`tpointone")
        }

        for ($i = 0; $i -lt $file.Length; $i=$i+6) {
            $temp = ($file | Select -Index $i) -split " "
            if($temp.Length -le 1){
            i++
            $temp = ($file | Select -Index $i) -split " "
            }
            $string = $temp[2].substring(0,($temp[2].Length-4))
            $string = $string + "`t" + $temp[11] + " " + $temp[12]
   
            for($j = 1; $j -lt 6; $j++){
                $temp2 = ($file | Select -Index ($i+$j)) -split " "
                $string = $string + "`t" + $temp2[$temp2.Length-2]

            }
            Add-Content -Path ($path +"\"+$fileName +"tempCVStxtFile.txt") ($string)
        }
        import-csv -Path ($path +"\"+ $fileName +"tempCVStxtFile.txt") -delimiter "`t" | export-csv -Path ($path +"\"+ $fileName + "csvfile.csv") -NoType

        $file3 = Import-CSV -Path ($path +"\"+ $fileName + "csvfile.csv")

        #$file3.game[2]

        $gameList = New-Object -TypeName "System.Collections.ArrayList"
        $gameList = [System.Collections.ArrayList]@()

        $file3 | ForEach-Object {
            $indexCount++

            if($gameList.Contains($_.game)){
                $gamename="$($_.game).txt"
                Add-Content -Path ($path +"\"+ $fileName + $gamename)("$($_.resolution)`t$($_.avg)`t$($_.min)`t$($_.max)`t$($_.onepercent)`t$($_.pointone)")
            }else{
                $gameList.Add($_.game)
                $gamename="$($_.game).txt"
                Add-Content -Path ($path +"\"+ $fileName + $gamename) ("resolution`tavg`tmin`tmax`tonepercent`tpointone")
                Add-Content -Path ($path +"\"+ $fileName + $gamename)("$($_.resolution)`t$($_.avg)`t$($_.min)`t$($_.max)`t$($_.onepercent)`t$($_.pointone)")
         
            }
    


        }

        $gameList.Clear()

        Remove-Item -Path ($path +"\"+ $fileName + "tempCVStxtFile.txt")
        cd ($path + "\" + $curDir1)
    }

    }
}

function getPlots{
    cd $path
    $textList = Get-ChildItem *.txt -Name 
    $textList | ForEach-Object{
        
        $TitleInfo=$_.substring(0,($_.Length-4))
        
        import-csv -Path ($_) -delimiter "`t" | export-csv -Path ($TitleInfo + ".csv") -NoType
        Remove-Item -Path ($_)

        $tempFile = "gameTempfile.txt"

        $file = Import-CSV -Path ($TitleInfo + ".csv")
        $rowCounter=0
        $stringTitle=""
        $stringNums=""
        for($i=1;$i -le 3;$i++){
            
            foreach($row in $file){
                $rowCounter++
                #Add-Content -Path ($path +"\"+ $fileName +"tempCVStxtFile.txt") ("game`tresolution`tavg`tmin`tmax`tonepercent`tpointone")
                if($i-eq 1){

                    if($stringTitle.Length -ge 1){
                        $stringTitle+="`t" + $row.resolution+" Average"
                    }else{
                        $stringTitle=$row.resolution+" Average"
                    }
                    if($stringNums.Length -ge 1){
                        $stringNums+="`t" + $row.avg
                    }else{
                        $stringNums=$row.avg
                    }
                }
                    #Add-Content $tempFile ($row.resolution+" Average`t"+$row.avg)
                #}else{
                #    if($i-eq 2){
                #
                #        if($stringTitle.Length -ge 1){
                #            $stringTitle+="`t" + $row.resolution+" 1% low"
                #        }else{
                #            $stringTitle=$row.resolution+" 1% low"
                #        }
                #
                #        if($stringNums.Length -ge 1){
                #            $stringNums+="`t" + $row.onepercent
                #        }else{
                #            $stringNums=$row.onepercent
                #        }

                        #Add-Content $tempFile ($row.resolution+" 1% low`t"+$row.onepercent)
                    #}else{
                    #   if($i-eq 3){
                    #
                    #        if($stringTitle.Length -ge 1){
                    #            $stringTitle+="`t" + $row.resolution+" 0.1% low"
                    #        }else{
                    #            $stringTitle=$row.resolution+" 0.1% low"
                    #        }
                    #
                    #        if($stringNums.Length -ge 1){
                    #            $stringNums+="`t" + $row.pointone
                    #        }else{
                    #            $stringNums=$row.pointone
                    #        }

                            #Add-Content $tempFile ($row.resolution+" 0.1% low`t"+$row.pointone)
                    #    }
                #    }
                #}                
            

            }
        }



        Set-Content $tempFile ($stringTitle)
        Add-Content $tempFile ($stringNums)
        Add-Content $tempFile ($stringNums)

        import-csv $tempFile -delimiter "`t" | export-csv plot.csv -NoType
        Remove-Item $tempFile
        

        $TitleInfo = $TitleInfo -split "_"

        Set-Content plot.gnuplot ("set title `""+ $TitleInfo[2] + ": "+$TitleInfo[0,1]+"`"")
        Add-Content plot.gnuplot("set key title `"Benchmarks`"")
        Add-Content plot.gnuplot("set ylabel `"Framerate`"")
        Add-Content plot.gnuplot("set key autotitle columnhead")
        Add-Content plot.gnuplot("set key outside")
        Add-Content plot.gnuplot("set datafile separator ','")
        Add-Content plot.gnuplot("set terminal pngcairo size 800,600 enhanced font 'Segoe UI,10''")
        Add-Content plot.gnuplot("set output '"+$TitleInfo[0,1,2] +".png'")

        $tempString="plot 'plot.csv' using 0:1 with lines"
        for($i = 2;$i -le $rowCounter;$i++){
            
            $tempString+=", '' using 0:"+$i+" with lines"
            
        }
        Add-Content plot.gnuplot($tempString)

        gnuplot plot.gnuplot

        
    }
}

function setDocker{
    $textList = Get-ChildItem *.png -Name
    Set-Content Dockerfile ("FROM nginx")


    #foreach($image in $textList){
        #Add-Content Dockerfile( "COPY "+$image +" /usr/share/nginx/html")
    #}
    #$copyString+="/usr/share/nginx/html"
    Add-Content Dockerfile( "COPY . ./usr/share/nginx/html")
    
    #Add-Content Dockerfile($copyString)

    docker run --rm kodid/graphs .
    docker build -t kodid/graphs .
    docker run -p 8888:80 kodid/graphs
}



getOrganized


getPlots

setDocker
