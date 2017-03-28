data {
  int<lower=0> N; // Number of data points
  vector[N] y; // Response variable
  vector[N] x; // Predictor variable
}
parameters {
  real slope;
  real intercept;
  real<lower = 0> sigma;
}
model {
  slope ~ normal( 0, 5);
  intercept ~ normal(0, 5);

  y ~ normal( intercept + slope * x, sigma);
}
