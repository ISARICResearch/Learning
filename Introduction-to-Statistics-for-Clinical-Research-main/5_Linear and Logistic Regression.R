# --- Load packages and dataset ---
library(dplyr)

# Read CSV from GitHub
df <- read.csv("https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv")

# Convert age to numeric (it may come as character if some cells are "")
age <- as.numeric(df$demog_age)

# Convert date columns to Date objects
df$outco_date   <- as.Date(df$outco_date,   format = "%Y-%m-%d")
df$dates_admdate <- as.Date(df$dates_admdate, format = "%Y-%m-%d")

# Compute length of stay (LOS) as difference between outcome date and admission date
df$outco_lengthofstay <- as.numeric(df$outco_date - df$dates_admdate)

# Ensure numeric age
df$demog_age <- suppressWarnings(as.numeric(df$demog_age))

# Keep only rows with valid numeric values for both age and LOS
ok <- is.finite(df$demog_age) & is.finite(df$outco_lengthofstay)

# ---- Output 1: Scatter plot ----
# This plot shows the relationship between age (x-axis) and length of stay (y-axis).
# Each point is a patient, and we can visually inspect whether older patients tend to stay longer.
plot(df$demog_age[ok], df$outco_lengthofstay[ok],
     xlab = "Age (years)",
     ylab = "Length of Stay (days)",
     main = "Length of Stay vs Age",
     pch = 19, cex = 0.7)

# ---- Output 2: Linear regression line ----
# Fit a simple linear regression: LOS ~ Age
lm_fit <- lm(outco_lengthofstay ~ demog_age, data = df[ok, ])

# Add the fitted regression line in red to the scatterplot
abline(lm_fit, col = "red", lwd = 2)

# ---- Output 3: Linear regression summary ----
# The summary shows:
# - Estimate of intercept and slope (β0 and β1)
# - Standard errors, t-values, and p-values
# - R-squared (proportion of variation in LOS explained by age)
# - Residual standard error (average prediction error)
summary(lm_fit)


##################################
# --- Logistic regression section ---
##################################

# Keep only patients with Death/Discharged outcomes and recode:
# Death = 1, Discharged = 0
df <- subset(df, outco_binary_outcome %in% c("Death", "Discharged"))
df$outco_binary_outcome <- ifelse(df$outco_binary_outcome == "Death", 1L, 0L)

# Recode sex: 1 = Male, 0 = Female, and drop other categories
df <- df %>%
  filter(demog_sex %in% c("Male", "Female")) %>%
  mutate(sex_binary = ifelse(demog_sex == "Male", 1L, 0L))

# Ensure predictors are numeric
df$demog_age <- as.numeric(df$demog_age)
df$labs_platelets_103ul <- as.numeric(df$labs_platelets_103ul)

# Remove rows with missing values in outcome or predictors
df_clean <- df %>%
  select(outco_binary_outcome, sex_binary, demog_age, labs_platelets_103ul) %>%
  na.omit()

# ---- Output 4: Logistic regression model ----
# Fit a logistic regression with mortality as the outcome (1 = death, 0 = discharged)
# Predictors: sex (male/female), age, platelet count
logit_model <- glm(outco_binary_outcome ~ sex_binary + demog_age + labs_platelets_103ul,
                   data = df_clean,
                   family = binomial)

# ---- Output 5: Logistic regression summary ----
# The summary shows:
# - Coefficients (log-odds scale) for each predictor
# - Standard errors, z-values, and p-values
# Interpretation tip:
#   A positive coefficient = higher log-odds of death (higher risk)
#   A negative coefficient = lower log-odds of death (protective)
summary(logit_model)

# ---- Output 6: Odds ratios with 95% CIs ----
# Exponentiate coefficients to obtain odds ratios (easier to interpret).
# Example:
#   OR = 1.76 → Males have 76% higher odds of death compared to females.
#   OR = 1.01 → Each year of age increases odds of death by ~1%.
exp(cbind(OR = coef(logit_model), confint(logit_model)))




