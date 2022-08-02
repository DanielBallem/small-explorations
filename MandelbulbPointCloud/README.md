## Mandelbulb calculation

### Created March 13th (uploaded much later)
---

Inspired by the coding train video on the same topic, I felt motivated to implement my own version of the mandelbulb in processing using a point cloud. 

Referring to a resource detailing the equations necessary to implement such a bulb, I managed to slowly understand exactly what was being done. It took a while, but I was quite satisfied by the result. 

At the time I made this, I had just begun my journey through reading Robert Martin's book on clean code. I was deadset on practicing it, and took this little project as an opportunity to try it out. 

You'll find throughout the source files that each method is incredibly small, having been extracted with descriptive function names and variables. Each function tries to clearly explain what it does on a need-to-know basis. 

I am quite pleased that after months of having this buried in my documents folder, I can jump to any function in the code and understand what it's doing. 

For example:

```Java
boolean isZetaBounded(PVector cartesianCoordinate) {
  int iteration = 0;
  PVector previousZeta = new PVector(0, 0, 0);
  
  while (iteration <= maxIterations) {
    SphericalVector currentZeta = mandelbulbIteration(previousZeta, cartesianCoordinate);
    iteration++;

    if (currentZeta.isGrowingToInfinity()) {
      if (atAnEdge)
        atAnEdge = false;
      return false;
    }
  }
  return true;
}
```

I can practically read this like a detailed instruction. 


To check if zeta is bounded, I...
- Go through an iteration of the mandelbulb equation, using the previous zeta and the given caterian coordinate.
- If that zeta value is growing to infinity, return false. Zeta is not bounded.
- Repeat until you go through all the iterations you want.
- Return false otherwise, since zeta never grew that means it is bounded.

