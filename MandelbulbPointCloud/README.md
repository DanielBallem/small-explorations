# Mandelbulb calculation

## Created March 13th (uploaded much later)

---
Inspired by the coding train video on the same topic, I felt motivated to implement my version of the Mandelbulb in processing using a point cloud. 

https://user-images.githubusercontent.com/33844493/182422646-38ff7c0b-71e7-4dc9-b74e-f4d86993ec8c.mp4

It's a very small program, but I quite enjoy it since it's been a topic I've been eager to tackle for a while. As well, it allowed me to practice author Robert Martin's clean code philosophy. Which, being my first time, is not so bad. 

# Process

To understand how to create a point cloud of a Mandelbulb, We need to first understand what a point cloud is, and how to draw a Mandelbulb with it.

Luckily, the first part is simple. A point cloud is a collection of points in 3D space.

![image](https://user-images.githubusercontent.com/33844493/182491088-bf341ef0-bd58-4cc7-9c67-423b7a053f73.png)

Given a number to define the dimensions of a volume, it's quite simple to iterate through each axis and draw a point at that location. The result of the following loop draws the point cloud of a cube. 

```Java
void drawCloud() {
   for (int i = 0; i < DIM; i++)
    for (int j = 0; j < DIM; j++)
      for (int k = 0; k < DIM; k++) {
        stroke(255);
        point(i, j, k);
      }
}
```

What's great about this volume, is that we can control what points are turned on and what points are turned off. If I wanted to make a sphere, I can just make a function that checks the distance between a given point and the origin. If it's under a certain threshold, then draw the point. Otherwise, skip it.

![image](https://user-images.githubusercontent.com/33844493/182492884-e261bf3a-1687-4dc8-8a17-3f682cb181d1.png)

```Java
void drawCloud() {
   for (int i = 0; i < DIM; i++)
    for (int j = 0; j < DIM; j++)
      for (int k = 0; k < DIM; k++) {
        stroke(255);
        if (isPointWithinRadius(25, new PVector(i,j,k)))
          point(i, j, k);
      }
}

boolean isPointWithinRadius(int radius, PVector v) {
  int midpoint = DIM/2;
  PVector center = new PVector(midpoint, midpoint, midpoint);
  
  return center.sub(v).mag() < radius;
}
```

This is the foundation for our Mandelbulb cloud. If we can determine how to know if a point is in the Mandelbulb set, then we draw it. Otherwise, we will not draw it.

## Calculating the mandelbulb.

Fortunately for me, there is a niche community that goes wild for fractals. The Mandelbulb, for those who don't know, is quite a famous 3D fractal. I won't get into details on fractals here, but if you want to check out a site with more information be my guest. https://www.skytopia.com/project/fractal/2mandelbulb.html

Towards the bottom of the page, it might be a little difficult to understand what exactly is being done to calculate whether a point is within the set. I'll do my best to explain it.

Equation for a mandelbulb
`z -> z^n + c`

`c` is the cartesian coordinate of the given point we want to check. In our point cloud, that's going to be our `PVector(i, j, k)` converted to a cartesian coordinate.
It's also important that we normalize the points between -1 and 1 for the sake of the calculations. You can find how I implemented it in the source code.

The `z` on the left-hand side is what we care about. For each iteration that we apply the formula above, we apply the previous `z` value to get our new and improved `z`. If we find that with each iteration, `z` grows to infinity - it's not in the set. If it stays bounded below a certain threshold, then it is within the Mandelbulb set.

What gets a little tricky is the `z^n` on the right side. It's not as one may think. It's the previous zeta, converted to a spherical vector, and then taken to the power of `n`, where `n` can be a range of numbers that will give us different-looking Mandelbulbs (see site for pictures). 

For all of these calculations, I heavily relied on the website to break them down so I can turn them into functions. Looking at my source code, you can see exactly how I'm iterating through each time and when I'm making those conversions. It's a lot easier to digest that way.

Finally, to exclude the middle points so that we only see the outline, every time a point is marked I say it's at an edge, and once we stop finding points in the set we say we're no longer at an edge. It's important to remember how we're iterating through each point, and how by the nature of the shape, we'll hit the edges first and last on a given side. That's why the points look a little spread out and wobbled, but it beats slowing my PC down. 


## Clean code. 

This was my first full attempt at writing something with clean code in mind. After I wrote the program to draw the Mandelbulb, I extracted methods where I could. Then I extracted it again, and again. I made sure that every method was incredibly small and had descriptive names. I think there may be a few names I could improve, but for being a first time I'm quite pleased. It's easy to see what each method does on a need-to-know basis.

## Conclusion.

I quite enjoyed this deep dive. It was a problem with many resources to help aid me, I was able to practice clean coding, and I finally cracked into a topic I've been meaning to wrap my head around for a while. A nice little program.
