# PlatformerGodot
 My first Platformer in Godot

# What I want to add:

Background, parallaxel (connect to the flying objects in each level)
20 levels
Lighting and shadows
more advanced camera setting such as looking up and down
death animation
fix the font at the first levels
and a CONTROLS tab at the start menu
ADD a level chooser
dash animation
add sound effects
add soundtrack



# mechanics:
teleporter
key
Add a crystal that resets your dash and jump
make the conveyor belts move you
jump pad tile

add different kind of movement that you will unlock later on



POST PROCESSING

PARALLAXEL
To get that ParallaxBackground working:
1. Create a ParallaxBackground node. (It doesn't need to be a child of the Camera2D node, 
	but making it a child of the Camera2D node won't break it either)
2. Create a ParallaxLayer node as a child of the ParallaxBackground.
3. Add your sprite as a child of the ParallaxLayer node and make sure Centered is off.
4. Go back to the ParallaxLayer node.
5. Under Motion, set Mirroring to the size of your sprite (in the case of the Sky sprite, 640x640).
6. Under Motion, fiddle with the Scale setting. This is how fast that ParallaxLayer will move in relation to the camera. 
	I found (0.1, 0.1) to be a good starting point for something like a sky.
7. Run your game, and you should have a background that infinitely loops and also has a parallax effect.
