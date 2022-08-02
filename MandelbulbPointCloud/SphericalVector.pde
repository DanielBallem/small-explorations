//Daniel Ballem

class SphericalVector {

  float r; //magnitude
  float theta; //rotation on one axis
  float phi; //rotation on another axis
  float defaultThreshold = 2;
  
  SphericalVector(float r, float theta, float phi) {
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
  
  SphericalVector(float r, float theta, float phi, float defaultThreshold) {
    this(r, theta, phi);
    this.defaultThreshold = defaultThreshold;
  }

  boolean isMagnitudeAboveThreshold(float threshold) {
    return r > threshold;
  }
  
  boolean isGrowingToInfinity() {
    return isMagnitudeAboveThreshold(defaultThreshold);
  }
}

SphericalVector cartesianToSpherical(PVector vector) {
  float x = vector.x;
  float y = vector.y;
  float z = vector.z;

  float r = sqrt(x*x + y*y + z*z);
  float theta = atan2(sqrt(x*x+y*y), z);
  float phi = atan2(y, x);

  return new SphericalVector(r, theta, phi);
}
