# --- Load packages and dataset ---
library(dplyr)

# Read dataset (same synthetic file you've been using)
df <- read.csv("https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv")

# --- Prepare variables: convert to numeric and remove missing values ---
df$labs_platelets_103ul <- as.numeric(df$labs_platelets_103ul)
df <- df %>% filter(!is.na(labs_platelets_103ul))

# --- 1) Reference Range (describes variability of individual values) ---
# Population (using the full, cleaned dataset)
platelet_mean <- mean(df$labs_platelets_103ul)
platelet_sd   <- sd(df$labs_platelets_103ul)

# 95% reference range: mean ± 1.96 * SD
ref_low  <- platelet_mean - 1.96 * platelet_sd
ref_high <- platelet_mean + 1.96 * platelet_sd

cat("\n--- Reference Range (individual values) ---\n")
cat(sprintf("Mean = %.2f, SD = %.2f\n", platelet_mean, platelet_sd))
cat(sprintf("95%% reference range: [%.2f, %.2f]\n", ref_low, ref_high))

# Optional: check whether a specific observed value falls inside or outside the reference range
# (Here we just take one observed value from the dataset)
obs_value <- df$labs_platelets_103ul[1]
cat(sprintf("Example observed value = %.2f -> %s the 95%% reference range\n",
            obs_value,
            ifelse(obs_value >= ref_low & obs_value <= ref_high, "INSIDE", "OUTSIDE")))

# --- 2) Confidence Interval for the mean (describes precision of the estimate) ---
# Draw a random sample of size n = 50 and compute mean, SE, 95% CI
set.seed(123)
n <- 50
samp <- sample(df$labs_platelets_103ul, n, replace = FALSE)

samp_mean <- mean(samp)
samp_sd   <- sd(samp)
samp_se   <- samp_sd / sqrt(n)

ci_low  <- samp_mean - 1.96 * samp_se
ci_high <- samp_mean + 1.96 * samp_se

cat("\n--- Confidence Interval (sample estimate) ---\n")
cat(sprintf("Sample size n = %d\n", n))
cat(sprintf("Sample mean = %.2f, SD = %.2f, SE = %.3f\n", samp_mean, samp_sd, samp_se))
cat(sprintf("95%% CI for the mean: [%.2f, %.2f]\n", ci_low, ci_high))
# cat(sprintf("95%% CI for mean age: [%.1f, %.1f]\n", ci_age_low, ci_age_high))



# --- Visualization 1: Histogram + mean and 95% reference range ---
hist(df$labs_platelets_103ul,
     breaks = 30,
     main = "Platelet Count: Distribution with 95% Reference Range",
     xlab = "Platelets (10^3/µL)")

abline(v = platelet_mean, lwd = 2)                 # mean
abline(v = ref_low,  lty = 2, lwd = 2)             # 95% ref low  (mean - 1.96*SD)
abline(v = ref_high, lty = 2, lwd = 2)             # 95% ref high (mean + 1.96*SD)

legend("topright",
       legend = c("Mean", "95% reference limits"),
       lty = c(1, 2), lwd = 2, bty = "n")



# Ensure platelets are numeric and non-missing
df$labs_platelets_103ul <- as.numeric(df$labs_platelets_103ul)
df <- df[!is.na(df$labs_platelets_103ul), ]

set.seed(123)

# Sample sizes to compare (trim to what's feasible given your data size)
n_vec <- c(20, 50, 100, 200, 400)
N <- nrow(df)
n_vec <- n_vec[n_vec <= N]

# Pre-allocate
k <- length(n_vec)
means <- numeric(k)
ci_lo <- numeric(k)
ci_hi <- numeric(k)

# Population mean for reference line
platelet_mean <- mean(df$labs_platelets_103ul)

# Compute mean and 95% CI for each n
for (i in seq_along(n_vec)) {
  n <- n_vec[i]
  s <- sample(df$labs_platelets_103ul, n, replace = FALSE)
  m <- mean(s); sd_ <- sd(s); se_ <- sd_ / sqrt(n)
  means[i] <- m
  ci_lo[i] <- m - 1.96 * se_
  ci_hi[i] <- m + 1.96 * se_
}

# Plot: CI width vs sample size (points with error bars)
x <- seq_along(n_vec)
plot(x, means,
     ylim = range(c(ci_lo, ci_hi)),
     xaxt = "n", xlab = "", ylab = "Mean platelets (10^3/µL)",
     main = "95% CI Narrows as Sample Size Increases", pch = 19)
axis(1, at = x, labels = paste0("n = ", n_vec))
arrows(x0 = x, y0 = ci_lo, x1 = x, y1 = ci_hi,
       angle = 90, code = 3, length = 0.07, lwd = 2)
abline(h = platelet_mean, lty = 3)
legend("topleft",
       legend = c("Sample mean ± 95% CI", "Population mean (full data)"),
       lty = c(1, 3), pch = c(19, NA), lwd = c(2, 1), bty = "n")

