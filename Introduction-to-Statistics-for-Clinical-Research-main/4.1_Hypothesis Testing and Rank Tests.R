# Read dataset (synthetic file)
df <- read.csv("https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv")

###################################
#Testing Differences Between Means#
###################################

# Make sure platelets are numeric
df$labs_platelets_103ul <- suppressWarnings(as.numeric(df$labs_platelets_103ul))

# Drop missing values for platelets and sex
df <- df[!is.na(df$labs_platelets_103ul) & df$demog_sex != "", ]

# Split groups
group_male   <- df$labs_platelets_103ul[df$demog_sex == "Male"]
group_female <- df$labs_platelets_103ul[df$demog_sex == "Female"]

# Boxplot by sex
boxplot(labs_platelets_103ul ~ demog_sex,
        data = df,
        main = "Platelet Counts by Sex",
        xlab = "Sex",
        ylab = "Platelets (10^3/µL)",
        col = c("orange", "yellow"))

# Two-sample t test
t_test_result <- t.test(group_male, group_female)
print(t_test_result)


