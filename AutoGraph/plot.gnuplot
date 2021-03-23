set title "SOTTR: 5950x Sapphire 6700XT"
set key title "Benchmarks"
set ylabel "Framerate"
set key autotitle columnhead
set key outside
set datafile separator ','
set terminal pngcairo size 800,600 enhanced font 'Segoe UI,10''
set output '5950x Sapphire 6700XT SOTTR.png'
plot 'plot.csv' using 0:1 with lines, '' using 0:2 with lines, '' using 0:3 with lines, '' using 0:4 with lines, '' using 0:5 with lines, '' using 0:6 with lines, '' using 0:7 with lines, '' using 0:8 with lines, '' using 0:9 with lines
