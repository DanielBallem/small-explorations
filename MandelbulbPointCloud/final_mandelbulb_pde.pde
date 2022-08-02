// Formulas for mandelbulb grabbed here: https://www.skytopia.com/project/fractal/2mandelbulb.html
// Daniel Ballem

import peasy.*;

int DIM = 64; // dimensions of the volume that will make up the mandelbulb point cloud
PeasyCam cam;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();
int n = 8; //power of n for each iteration. Change for different mandelbulbs
int maxIterations = 10;
boolean atAnEdge = false; //keeps track of whether or not we're at an edge. Points will only be made of edges
int magnifier = 100; //scales final coordinates for viewing pleasure.

void setup() {
  size(600, 600, P3D);
  windowMove(1200, 100);
  cam = new PeasyCam(this, 500);
  generateMandelbulb();
}

void generateMandelbulb() {
  for (int i = 0; i < DIM; i++)
    for (int j = 0; j < DIM; j++)
      for (int k = 0; k < DIM; k++) {
        PVector cartesianCoordinate = mapDimentionsToNormalizedCartesianVector(i, j, k);
        addPointIfInMandelbulbSet(cartesianCoordinate);
      }
}

void addPointIfInMandelbulbSet(PVector cartesianCoordinate) {

  boolean zetaIsBounded = isZetaBounded(cartesianCoordinate);

  if (zetaIsBounded) {
    //add this point, but don't draw any more until atAnEdge is false again.
    if (!atAnEdge) {
      atAnEdge = true; 
      mandelbulb.add(new PVector(cartesianCoordinate.x*magnifier, cartesianCoordinate.y*magnifier, cartesianCoordinate.z*magnifier));
    }
  }
}

//A point is considered "bounded" if the result of the iterations never grows to infinity.
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

SphericalVector mandelbulbIteration(PVector zeta, PVector cartesianCoordinate) {

  SphericalVector sphericalZeta = cartesianToSpherical(zeta);
  PVector sphericalZetaPow = sphericalPow(sphericalZeta, n);

  //Equation: zeta = (spherical zeta) ^ n + C
  zeta.x = sphericalZetaPow.x + cartesianCoordinate.x;
  zeta.y = sphericalZetaPow.y + cartesianCoordinate.y;
  zeta.z = sphericalZetaPow.z + cartesianCoordinate.z;

  return cartesianToSpherical(zeta);
}

void draw() {
  background(0);
  drawPointsInMandelbulbSet();
}

void drawPointsInMandelbulbSet() {
  for (PVector v : mandelbulb) {
    stroke(255);
    point(v.x, v.y, v.z);
  }
}
