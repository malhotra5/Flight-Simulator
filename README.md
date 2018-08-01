# Flight-Simulator
A flight simulator made from scratch using the graphical capabilities of processing.
## Getting Started
These instructions will help get the flight simulator up and running. 
### Prerequisites
Get the processing environment, an open-source graphical library. This code can be replicated to be  written in Python also. I have done it in Java. Visit this website for more information about the python environment - https://github.com/jdf/processing.py \
The processing environment looks like the following - 

![GitHub Logo](/Pictures/procEnv_Java.jpg)

Be sure to set the programming language to which ever one you want. This can be done by looking at the top right corner. Notice, the picture above says **"Java"** in the top right corner.

![GitHub Logo](/Pictures/procEnv_Python.jpg)

### Installing 
Download the zip for this repository or use git on the terminal. The terminal command is - 
    
    git clone https://www.github.com/malhotra5/Flight-Simulator

## Running
To run the following, click the run button on the top left - 

![GitHub Logo](/Pictures/run.jpg)

## How it works
All the code in this repository is done from scratch using only processing's graphics functions. There are more powerful tools out there such as Unity. This code is for the people who want to know how graphics work and implement some of it from scratch.  
### Making the landscape
To make the landscape, we have to read about how graphics are made. To make graphics, people use shapes. People used to use squares, to make complex objects. But, rendering graphics, or in other words displaying graphics became costly and time consuming. Also, squares are not the ideal way to go for making extremely graphic models. Sooner or later, people shifted into using triangles, or a combination of multiple shapes. See this youtube video for extra information - https://www.youtube.com/watch?v=cvcAjgMUPUA \

Now, we will make our landscape using traingle strips. This is a series of triangles put together in a row, or in our case multiple rows. First, lets make our triangle strip. We can do this using this method. For the people who are using the python code, I have tried to make it as similar as possible to the Java code. So following this tutorial shouldn't be that much of a problem.

     public void render(int rows, int cols){
        for (int y = 0; y < rows-1; y++) {
            beginShape(TRIANGLE_STRIP);
            for (int x = 0; x < cols; x++) {
                vertex(x*scl, y*scl);
                vertex(x*scl, (y+1)*scl);
            }
            endShape();
     }
     
 This method creates the following like grid of triangles.
 
 ![GitHub Logo](/Pictures/triangleStrip.jpg)
 
 To make it look like a landscape, we can perform the following transformations.
 
    ```
    translate(width/2, height/2+500);
    rotateX(PI/3);
    translate(-w/2, -h/2);
    ```
    
This gives the following - 

 ![GitHub Logo](/Pictures/initLand.jpg)

The ground still looks very flat and artificial. To add various bumps and mountainous like structures, we can meddle with the traingles z-values. When setting up the size of the window, we have specified the window to support 3D points with the following command - 

    size(600, 600, P3D);    //Notice the 3D when specifying the size of the window

To specify z-values, we need to change the coordinates of the vertices in the triangle strip. 


### Moving the landscape


### Making graphics for plane's pitch

### Making graphics for plane's roll

### Detecting collision

### Adding color

## Built With
Java and Python. Evnvironment - Processing.

## Acknowledgments
Daniel Shiffman - Perlin Noise

## Tasks in progress 
I am working to replicate the work I have done into Python. Additional flight features such as the roll for the plane need to be added.

