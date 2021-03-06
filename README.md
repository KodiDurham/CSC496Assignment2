﻿[Home](https://kodidurham.github.io/CSC496Assignment2/) |   [Benchmarks](https://kodidurham.github.io/CSC496Assignment2/Benchmarks)

# **CSC496 Assignments**
This is a test/assignment repo for my CSC 496 class. The Game's benchmarks and logs are organized by folders.

## **Game Benchmarks**
- Borderlands 2 *(From Epic Game Store)*
- Fallout: New Vegas *(From Steam)*
- Medium *(From Xbox App - Game Pass Ultimate)*
- Skyrim Special Edition *(From Steam)*

## **Naming Convictions**
GameNameB# => Output from HWiNFO64 for benchmark #

GameNameB#AfterBurner => Output from AfterBurner for benchmark #

## **Information about Computer Used:**
- CPU: Intel Core i5-4690K
- GPU: MSI GTX 960

## **About the Games**

Benchmarks 2: Had high preformace mode on.

Benchmarks 3: Had power save mode on. 

Graphs: I made two graphs to better get the difference between Benchmarks 2 and 3. There is also a graph that contains every benchmark for each game.

### **Borderlands 2**
Borderlands 2 had the best preformance while playing with the FPS getting surprisingly high with little issues while playing. During this play time I played I ran around starting at the ice village and played through to beating caprain Flynt as the character Gaige. Both CPU and GPU were taxed and was heating up the tempurtures. Resolution was 1920 x 1080

Benchmark 2 & 3: played unti first boss and loaded into liar's berg resolution was 1680 x 1050

Graphs:

![](Borderlands2/B1B2B3.png)
![](Borderlands2/B2B3.png)

### **Fallout: New Vegas**
Fallout: New Vegas is an older game so the gpu and cpu didnt struggle as much as the other games on the list, but still wasnt the best. Heat was an issue with the game it was slowing building while I was playing. While I was playing, I ran around Goodsprings (the starting town) and killed NPCs and animals in third person. I tried to get the cinamatic view to see if there would be issues with them, but it didnt seem to affect the stats much. Resolution was 800x 450 in window mode.

Benchmark 2 & 3: Resolution was 1280 x 720 in window mode.

Graphs:

![](FalloutNewVegas/B1B2B3.png)
![](FalloutNewVegas/B2B3.png)

### **Medium**
Medium is a new game with intresting mechanic where it will split the screen for two views one of a spiritual world and the real world. I noticed when I first played it that when that happens both views get highly pixelated. The benchmark started when I got to the point where I could move around in both worlds and aquire the first upgrade and stopped when I got to the big building. Both cpu and Gpu struggled on the lowest settings in the game. The heat was slowing growing to 65 degrees. I assume they must pixilate the the view for it to be playable. Once the teo worlds mechanic stops the framerates starts to be slightly higher. Resolution was 1920 x 720.

Benchmark 2 & 3: Resolution was 1280 x 720.

Graphs:

![](Medium/B1B2B3.png)
![](Medium/B2B3.png)

### **Skyrim**
For Skyrim I started out from the beginig of the game and stopped at exting the cave in the beginning. I tried to look at the dragon breathing fire and use spells to see if that would affect the preofrmace much and tried to move rapid. The rapid movement and jumping a lot caused the most issues with CPU. Resolution was 1920 x 1080.

Benchmark 2 & 3: Resolution was 1600 x 900. I played until you got your first weapon and entered combat.

Graphs:

![](Skyrim/B1B2B3.png)
![](Skyrim/B2B3.png)


## **About the Command Line Input example**
![](CommandLine.PNG)

## **About the .gnuplot file example**

set title "Borderlands 2 Framerates"

set key title "Benchmarks"

set xlabel "Time"

set ylabel "Framerate"

set key autotitle columnhead

set datafile separator ','

set terminal pngcairo size 800,600 enhanced font 'Segoe UI,10'

set output 'B1B2B3.png'

plot 'frames.csv' using 0:1 with lines, '' using 0:2 with lines, '' using 0:3 
with lines

 or see [plotB1B2B3.gnuplot](Borderlands2/plotB1B2B3.gnuplot)
