# Power Simulation Example using expand.grid and mapply instead of a for loop
# Ian Dworkin last modified March 14th, 2024 (BIO708, QMEE)


#Global Parameter values
a = 0 # intercept
b <- seq(from = 0, to = 1.0, by = 0.1) # slope
std_dev = seq(from = 0.1, to = 2, by = 0.1) # residual standard deviation 
sample_size <- seq(from = 5, to = 50, by = 5)


# use expand grid to get all combinations of b and sample_size
b_N <- expand.grid(b, sample_size, std_dev)  # look at  b_N to see what is being stored, and how.
dim(b_N)
colnames(b_N) <- c("b", "sample_size", "std_dev") 

# Here is the function to generate the simulation and fit the model given the simulated data.
SimulatePower <- function(sample_size, b_b, a, std_dev){
	x <- rnorm(sample_size, mean=0, sd=1)
	y_det <- a + b_b*x
  y_sim <- rnorm(sample_size, mean=y_det, sd=std_dev)
  lm1 <- lm(y_sim ~ x)
  pval <- coef(summary(lm1))[2,4]
 }

# We can use this for one sample_size and slope to check everything is working. Let's do 100 simulations
check_it_works <- replicate(100, 
              SimulatePower(sample_size=15, b_b = 0.4, a = 0, std_dev = 3))

hist(check_it_works, freq = T)

# The basic approach works like this. This goes through all combinations of sample_size and b (in b_N) and runs the SimulationPower().
p_values <- mapply(SimulatePower, 
    sample_size  = b_N$sample_size, b_b = b_N$b,  std_dev = b_N$std_dev,
    MoreArgs = list(a=0)) 

system.time(
# And if we want to repeat this, we can do it easily with replicate    
rep_p <- replicate(100, 
              mapply(SimulatePower, 
                     sample_size = b_N$sample_size, 
                     b_b = b_N$b, 
                     MoreArgs=list(a = 0, std_dev = 1)))
)

# Each row represents a distinct combination of sample size and slope. Each column an iteration of that simulation
dim(rep_p)

# Now we can compute the power. We use the apply function to determine the fraction of p-values less than 0.05

power_lev <- apply(rep_p, MARGIN = 1, 
    function(x) length(x[x <= 0.05])/length(x)) # how many p-values are less than 0.05


# The only problem with this approach is that you need to make the matrix of p-values, which are otherwise just stored as a single vector
grid_matrix <- matrix(data=power_lev, nrow=length(b), ncol=length(sample_size))

persp(x = b ,y = sample_size, z= grid_matrix, col = rgb(0, 0, 1, 0.5), 
    theta = -10, shade = 0.75, phi = 15, d = 2, r = 0.1,
    xlab = "slope", ylab = "sample size", zlab="power", 
    ticktype="detailed")

contour(z = grid_matrix, y = sample_size, x = b, col = "blue", xlab = "slope", ylab="Sample Size")

filled.contour(z = grid_matrix, y = sample_size, x = b, 
    xlim = c(min(b), max(b)), 
    ylim = c(min(sample_size), max(sample_size)), 
    ylab ="Sample Size", xlab = "slope", color = topo.colors,
    key.title = title(main = "power"),)

 