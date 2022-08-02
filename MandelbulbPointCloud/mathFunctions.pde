//Daniel Ballem

PVector mapDimentionsToNormalizedCartesianVector(int i, int j, int k) {
  float x = map(i, 0, DIM, -1, 1);
  float y = map(j, 0, DIM, -1, 1);
  float z = map(k, 0, DIM, -1, 1);
  return new PVector(x, y, z);
}

//calculates the power of a spherical coordinate. (like 2^n but on a spherical 3D plane)
PVector sphericalPow(SphericalVector sv, int n) {
  float r = sv.r;
  float theta = sv.theta;
  float phi = sv.phi;

  float newx = pow(r, n) * sin(theta*n) * cos(phi*n);
  float newy = pow(r, n) * sin(theta*n) * sin(phi*n);
  float newz = pow(r, n) * cos(theta*n);

  return new PVector(newx, newy, newz);
}
