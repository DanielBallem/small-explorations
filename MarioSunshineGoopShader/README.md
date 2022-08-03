## Mario Sunshine Goop in Unity using URP Shader Graph

https://user-images.githubusercontent.com/33844493/182723729-bea21666-1d70-4c8d-8e82-977fe0449ecb.mp4

##### capture software moves my mouse up. In reality, it's on point with the center of the sphere. 
---

One of my favourite games growing up was Super Mario Sunshine on the Game Cube. For years it continued to be my "comfort game" as I ran around and admired the unique and tropical atmosphere. It really captured my imagination. 

One of the most notable aspects of the game is Mario Sunshine's goop. A thick and harmful substance that would cling onto surroundings and spawn enemies.

![image](https://user-images.githubusercontent.com/33844493/182473867-c4dd5b55-94d8-4a23-b173-b3d04b35c41b.png)

As a kid, I was incredibly bewildered as to how they could have achieved it. To be able to paint any surface and spawn creatures from it. However, now that I'm much older and can do some basic research, I realized how limiting and simple it actually is.

I used to think it was all dynamic until I discovered through a file dump that every single goop or "pollution" spread is dictated by a flat texture that spans across a section of a map. This would be applied on top of a floor or wall to control what could be polluted and what its shape of it would be. 

![image](https://user-images.githubusercontent.com/33844493/182474311-0d99e31e-9d83-4724-b805-7fe2eb7b7e20.png)

As soon as I realized how easy it would be, I immediately booted up unity and hopped into shader graph.

## Process

### Goop shader

First things first, I know I needed two textures. The goop image itself, and the texture will dictate what parts are covered and what are not. For testing purposes, I hopped onto an online photo editing tool and made a quick black-and-white image. We'll see in a second how that's going to be done.

The next task was hopping into shader graph and setting everything up. To block certain areas from showing, we can simply use the black and white texture as an alpha map. This will map onto the object's UVs and tell Unity whether or not this material should be rendered here.

![image](https://user-images.githubusercontent.com/33844493/182724500-5544ef42-6adb-4678-b3b2-01c7a7086877.png)

Ignoring everything else for a second, we can see that as soon as I plug in the image to be used as an alpha map, it automatically hides specific parts of the material. If you're curious, you can try creating an image that involves combinations of white, black, and gray, and notice how adjusting the alpha threshold changes what is allowed to pass through. 

Regardless, I also took the opportunity to roughly patch together a normal map for this thing, so that we can get some resemblance of texture around the edges.

The final part of the texture itself was making the goop move/jiggle. I didn't want to spend forever tweaking the values just right, but I did come up with something that fits the bill.

 ![image](https://user-images.githubusercontent.com/33844493/182725066-0a0b2acc-d5b3-4d9c-a012-59577a780181.png)

All I'm doing is manipulating the UVs of the object over time, applying tiny transformations, and warping the texture using a generate Voronoi texture.

If you're curious about what a UV is, or what a Voronoi is. You can check Wikipedia! 

### Aside, I did accidentally come across this fun mess of a UV, which might be good for something down the road. It looks pretty psychedelic. 

https://user-images.githubusercontent.com/33844493/182725391-97558b5e-ba7a-4700-8614-4e920ad22f67.mp4

### Drawing on a texture.

The amazing thing about this setup is that it only relies on a single texture to dictate what's covered in goop. If we were able to manipulate this texture we could be able to splat or clean however we please - and if we do it right, with whatever we please. 

Essentially, the next part involves creating a helper class called `TextureDrawHelper` that any script can import. This will handle all the busy work of getting a texture's reference, seeing if it can be edited, and making the changes. All each object has to do is call `DrawCirclAtPoint...`, with no other context needed.

In the example program, I've set up the camera to shoot a Raycast towards the mouse cursor, and if it intersects with anything - try to draw a circle on that texture.

You can see how I implemented it in the source code, but from here it would be relatively the same for any kind of impact with the texture. A ball rolling across the surface would have an intersection or collision raycast which could be passed in. A "water bubble" could do the same, and colour the alpha mask black at point X, as if to clean it up. It's quite simple to build off from here.

## Conclusion.

This has almost been a guilty pleasure for me, and it makes me feel like I've come full circle as a dev. Being amazed at something as a kid, and then being able to implement it as an adult feels quite nice. I didn't go into detail on how I implemented the drawing of a texture, but quite honestly the code speaks for itself. I've tried to make it as readable as possible.  


