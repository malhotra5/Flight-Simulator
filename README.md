# Flight-Simulator
A flight simulator made from scratch using the graphical capabilities of processing.
## Getting Started
These instructions will help get the flight simulator up and running. This repository is still under work so I will be updating the repository as I go along finishing my program. A lot of the work will be dirty but after a few days this project should be completed. Once the project is completed I will take these words out of the repository. Thanks - Rohit Malhotra
### Prerequisites
Get the processing environment, an open-source graphical library. This code can be replicated to be  written in Python also. I have done it in Java. Visit this website for more information about the python environment - https://github.com/jdf/processing.py 
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
To make the landscape, we have to read about how graphics are made. To make graphics, people use shapes. People used to use squares, to make complex objects. But, rendering graphics, or in other words displaying graphics became costly and time consuming. Also, squares are not the ideal way to go for making extremely graphic models. Sooner or later, people shifted into using triangles, or a combination of multiple shapes. See this youtube video for extra information - https://www.youtube.com/watch?v=cvcAjgMUPUA. 

Now, we will make our landscape using traingle strips. This is a series of triangles put together in a row, or in our case multiple rows. First, lets make our triangle strip. We can do this using this method. For the people who are using the python code, I have tried to make it as similar as possible to the Java code. So following this tutorial shouldn't be that much of a problem.
```java
     public void render(int rows, int cols){
        for (int y = 0; y < rows-1; y++) {
            beginShape(TRIANGLE_STRIP);
            for (int x = 0; x < cols; x++) {
                vertex(x*scl, y*scl);
                vertex(x*scl, (y+1)*scl);
            }
            endShape();
     }
```   
This method creates the following like grid of triangles. Note that I have initialized the variables rows and cols. This just defines how many columns and rows we want to make the triangle strip for. You will see the significance of making a variable for the number of columns and rows later on in this READ.me.  
 
 ![GitHub Logo](/Pictures/triangleStrip.jpg)
 
 To make it look like a landscape, we can perform the following transformations.
 ```java
    translate(width/2, height/2+500);
    rotateX(PI/3);
    translate(-w/2, -h/2);
 ```
This gives the following - 

 ![GitHub Logo](/Pictures/initLand.jpg)

The ground still looks very flat and artificial. To add various bumps and mountainous like structures, we can meddle with the traingles z-values. When setting up the size of the window, we have specified the window to support 3D points with the following command - 
```java
    size(600, 600, P3D);    //Notice the 3D when specifying the size of the window
```
To specify z-values, we need to change the coordinates of the vertices in the triangle strip. We can create a 2D array of z values for each vertex in the traingle strip. Then we can use these z-values and assign them to each vertex. We define the z-values using the following - 
```java
    float[][] terrain; //Initialize 2D array
    terrain = new float[cols][rows]; // Assign to 2D array
    
    float yoff = flying;
    for (int y = 0; y < rows; y++) {
        float xoff = 0;
        for (int x = 0; x < cols; x++) {
            terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100); //Create a random value for z and map it between a value
            xoff += 0.07;
        }
        yoff += 0.07;
    }
```
Notice that we used the noise function to create a random value. If you choose to use a random value instead, you will notice the  z values to be extremely different, which will make the land look very artifical. We use the noise (perlin noise) function to get more of a natural like look by getting random numbers that are relatively close to each other. Later on, you will see 2 pictures, showing the difference between the noise and the random function. 

To create the z value, we take the render method that was previously shown and add the z values to each vertex. The following is the new render method.
```java
    public void render(int rows, int cols, float[][] terrain){
        for (int y = 0; y < rows-1; y++) {
        beginShape(TRIANGLE_STRIP);
            for (int x = 0; x < cols; x++) {
                vertex(x*scl, y*scl, terrain[x][y]);
                vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
            }
        endShape();
        }
 
    }
``` 
This will give us the following landscape. The first one is without noise, the second one is with the noise. Credits to Daniel Shiffman for his amazing tutorials on Perlin Noise on the coding train. You can find more information about Perlin Noise over here - https://en.wikipedia.org/wiki/Perlin_noise

 ![GitHub Logo](/Pictures/withoutNoise.jpg)| ![GitHub Logo](/Pictures/noise.jpg)
 ----------------------------------------- |---------------------------------------
 Landscape without noise|Landscape with noise


### Moving the landscape
Now that we have made the landscape, we need to add the effect of it moving. To make it look like that, we can constantly adjust the noise across the Y-axis, to make the land move. The following addition of code does that. Notice that the variable yoff, that has been assigned to flying, is used during the intialization of the Z-axis values for the noise. 
```java     
     flying -= flyRate; //flyrate is a constant. You can meddle with this value
     float yoff = flying; // We constantly adjust the value of yoff using flying
```     
This results in the following - 

 ![GitHub Logo](/Pictures/noiseMove.gif)

### Making graphics for plane's pitch
This following diagram explaines the pitch, roll and yaw directions of an aircraft. These following pieces of code work with the pitch of a plane.

 ![GitHub Logo](/Pictures/airDirections.png)

There are 4 parts to it - 
* When we press the up or down arrow key, the angle at which we see the ground should change
* The angle of the view towards the ground should determine how high we are relative to the ground. Higher we go, the lower the land should go
* The size of the land is at a set size. We need to make it more dynamic. The higher the plane goes, the more of the land you can see. Therefore, the higher the plane goes, larger the amount of land needed
* When the plane comes near the ground, it should seem relatively faster than when the plane is higher above the ground

#### Part 1 - Adjusting the view of the plane 
Lets start by assigning some keys to the pitch control. Similar to a plane, the *Down* arrow will make the plane's view move up. The *Up* arrow will make the plane's view move down. We can make a keyPressed() function for this task. 

When we performed the transformation on the triangle strips, we rotated the X,Y and Z axis by 60 degrees. Now, we can assign that to a variable angle. Using the key binds (the up and down arrow keys), we can adjust the angle of the land to make it look like we are adjusting the view of the plane. The following code explaines it. 
```java
    void keyPressed(){
        if(key == CODED){ //Check if the keys are pressed
            if(keyCode == UP){ 
                angle -= 0.05; //Adjust the angle of the axis to adjust the view of the aircraft 
            }
            if(keyCode == DOWN){
                angle += 0.05;
            }
        }
    }
```
This code results in the following - 

 ![GitHub Logo](/Pictures/angleAdjust.gif)
 
#### Part 2 - Adjusting the height of the land
Now that we have adjusted the angle of view, we need to make like the plane is going higher or lower in the air, based on the angle. The plane should soar into the sky if the angle is extremely high, and plumet to the ground if the angle is extremely low. 

When we did the transformations at the start of this READ.me, we had performed 2 tranlations. Turns out, if we can change the transformations to support 3D values, then we can adjust the height of the ground. If the angle is very high, we start to push the ground away, if the angle if very low, we start to pull the ground towards the plane. This creates the visual effect of the plane flying.The new transformations are - 
```java
    translate(width/2, height/2+500,0); //Notice the z-value
    rotateX(angle); //This was the previously adjusted transformation for the pitch of the plane
    translate(-w/2, -h/2,  -altitude); //Notice the z value. This is the value we wil adjust for the height of the ground. The variables                                                            // h and w wil be explained later
```
We can now define the variable **height** above to be a function of the angle of the plane. The picture below wil help give some intuition about it. 

![GitHub Logo](/Pictures/heightDiagram.jpg)

Notice that we are interested in the new height. If you are familiar with vectors, you can determine the velocity of the plane using the angle and the speed at which the plane flies. We defined this speed earlier to be the variable **flyRate**. Now, using this vector diagram, we can use the law of sines to determine the **new height**. This new height is the **sin of the angle x flyRate**. Therefore, we can keep adjusting the height of the plane by adding **original height + new height**. There is a catch though. We set the original angle of the plane to be at an angle of 60 degrees. So, when we calculate **new height**, we must subtract 60 degrees from the original angle. This way, when the plane starts, it is always moving straight. Not up or down. 
The following code adjusts height - 
```java
    altitude = altitude + sin((angle-PI/3))*flyRate*1000; //We multiply the result into 1000 to make any significant progress.
```
The following illustrates the results of the new changes - 

![GitHub Logo](/Pictures/Flying_Up_Down.gif)

#### Part 3 - Making the size of the land more dynamic
During the creation of the traingle strips, we passed in variables for the number of columns and rows. This determined how big our traingle strip was. If you fly the plane high enough, you will start to see the ends of the triangle strips. This can be seen below.

![GitHub Logo](/Pictures/sizeLand.jpg)

We need to make sure that we increase the number of columns and rows as we go higher into the air. Later, we can add water or something else. For now I will keep it simple. 


**Work in progress** 

#### Part 4 - Adjusting aircraft speed depending on the height

**Work in progress**


### Making graphics for plane's roll
The roll is currently controlled by the Y-axis. Although, those who have flown a flight simulator before would know that the roll of the aircraft, has an influence on it's yaw. We can control it using the *A* and *D* keys. Lets also initialize variables for roll and yaw then update them. We don't want too drastic of changes to the yaw, so we divide it by 100. 
```java
    if(key == 'd'){
        roll-= 0.07;
        yaw = roll/100;
    }
    if(key == 'a'){
        roll += 0.07;
        yaw = roll/100;
    }
```
You can add this piece of code to your keyPressed() function. We use the roll and yaw to manipulate the Y and Z axis. We don't really move the plane, we move the axis to make it look like we are moving the plane. We also need to initialize a variable **prevYaw**. This is the yaw value we will constantly update. We will use the roll values above, and the updated yaw values like so - 

```java
    rotateY(roll);
    prevYaw += yaw;
    rotateZ(prevYaw);
 ```   
 The reason for using **prevYaw** is to make sure that we are constantly moving the Z-axis as long as the Y-axis is tilted. 

## Tasks in progress 
I am working to replicate the work I have done into Python. Additional flight features such as the roll for the plane need to be added.

## Things to take away
This is an example of how graphics used to be built. This serves as a foundation to understanding how powerful graphics can be made by simple and creative collection of shapes. 

## Things to improve
These are the things you could improve
* Add color - Color each triangle based on it's height in the z axis and the chosen orientation for the sun 
* Collision detection - Detect collisions by determining whether you have passed the ground 

## Built With
Java and Python. Evnvironment - Processing.

## Acknowledgments
Daniel Shiffman - Perlin Noise





