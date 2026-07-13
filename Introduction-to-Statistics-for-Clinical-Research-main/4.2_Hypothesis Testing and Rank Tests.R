######################################################################
#Testing Differences Between Categorical Variables (Chi-Squared Test)#
######################################################################
df <- read.csv("https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv")

# Keep only Male/Female and outcomes Discharged/Death (drop Censored and empties)
df2 <- subset(
  df,
  demog_sex %in% c("Male", "Female") &
    outco_binary_outcome %in% c("Discharged", "Death") &
    demog_sex != "" &
    outco_binary_outcome != ""
)

# 2x2 contingency table: Sex x Outcome
tab_sex_mortality <- table(Sex = df2$demog_sex, Outcome = df2$outco_binary_outcome)
tab_sex_mortality
addmargins(tab_sex_mortality)  # with totals

# Expected counts (check assumptions)
chi$expected

# Chi-squared test (without Yates correction by default for teaching clarity)
chi <- chisq.test(tab_sex_mortality, correct = FALSE)


