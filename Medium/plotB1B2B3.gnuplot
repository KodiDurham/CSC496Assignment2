set title "Medium Framerates"
set key title "Benchmarks"
set xlabel "Time"
set ylabel "Framerate"
set key autotitle columnhead
set datafile separator ','
set terminal pngcairo size 800,600 enhanced font 'Segoe UI,10'
set output 'B1B2B3.png'
plot 'frames.csv' using 0:1 with lines, '' using 0:2 with lines, '' using 0:3 with lines