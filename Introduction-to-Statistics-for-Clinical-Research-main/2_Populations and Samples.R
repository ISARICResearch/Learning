# --- Load packages and dataset ---
library(dplyr)

# Read dataset (synthetic, replace with real source if needed)
df <- read.csv(
  "https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv"
)

# Convert platelets to numeric
df$labs_platelets_103ul <- as.numeric(df$labs_platelets_103ul)
df <- df[!is.na(df$labs_platelets_103ul), ]

# Function to compute summary stats (mean, SD, SE) for a sample
sample_summary <- function(x) {
  x <- na.omit(x)
  n <- length(x)
  mean_x <- mean(x)
  sd_x <- sd(x)
  se_x <- sd_x / sqrt(n)
  return(data.frame(
    Mean = round(mean_x, 1),
    SD = round(sd_x, 1),
    SE = round(se_x, 2),
    N = n
  ))
}

df[!is.na(df)]
summary_pop <- sample_summary(df$labs_platelets_103ul)

# --- 1. Simple random sample (n=20) ---
set.seed(123) # for reproducibility
samp_random <- sample_n(df, 20)
summary_random <- sample_summary(samp_random$labs_platelets_103ul)

# --- 2. Systematic sample (every 10th patient) ---
samp_systematic <- df[seq(1, nrow(df), by = 10), ]
samp_systematic <- head(samp_systematic, 20) # take first 20 for comparability
summary_systematic <- sample_summary(samp_systematic$labs_platelets_103ul)

# --- 3. Stratified sample (by sex, 20 from each group) ---
samp_stratified <- df %>%
  group_by(demog_sex) %>%
  sample_n(20, replace = FALSE)
summary_stratified <- sample_summary(samp_stratified$labs_platelets_103ul)

# --- 4. Convenience sample (first 100 rows) ---
samp_convenience <- head(df, 100)
summary_convenience <- sample_summary(samp_convenience$labs_platelets_103ul)

# --- Combine results for comparison ---
results <- rbind(
  Populaton = summary_pop,
  Random = summary_random,
  Systematic = summary_systematic,
  Stratified = summary_stratified,
  Convenience = summary_convenience
)

print(results)


#####################################

# Assume df is already cleaned (no NAs in labs_platelets_103ul)

# Different sample sizes to test
sample_sizes <- c(10, 20, 50, 100, 200, 500)

# Container for results
se_results <- data.frame(
  n = integer(),
  Mean = numeric(),
  SD = numeric(),
  SE = numeric()
)

set.seed(123) # reproducibility

# Loop over sample sizes
for (n in sample_sizes) {
  samp <- sample(df$labs_platelets_103ul, n, replace = FALSE)
  stats <- sample_summary(samp)
  se_results <- rbind(
    se_results,
    data.frame(n = n, Mean = stats$Mean, SD = stats$SD, SE = stats$SE)
  )
}

print(se_results)

# Plot SE vs n
plot(
  se_results$n,
  se_results$SE,
  type = "b",
  pch = 19,
  xlab = "Sample size (n)",
  ylab = "Standard Error",
  main = "Standard Error vs Sample Size"
)
