# --- Packages
library(survival)

# --- Load data (your base)
df <- read.csv("https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv")

# Convert types
df$demog_age     <- suppressWarnings(as.numeric(df$demog_age))
df$outco_date    <- as.Date(df$outco_date,    format = "%Y-%m-%d")
df$dates_admdate <- as.Date(df$dates_admdate, format = "%Y-%m-%d")

# Length of stay (days) from admission to outcome date
df$outco_lengthofstay <- as.numeric(df$outco_date - df$dates_admdate)

# Binary outcome already set by you: 1 = Death, 0 = Discharged alive
df$outco_binary_outcome <- ifelse(df$outco_binary_outcome == "Death", 1L, 0L)

# --- Prepare analysis dataset
df_km <- subset(
  df,
  is.finite(outco_lengthofstay) & outco_lengthofstay >= 0 & !is.na(outco_binary_outcome)
)

# Time and event
df_km$time  <- df_km$outco_lengthofstay
df_km$event <- df_km$outco_binary_outcome

# (Optional) nudge zero-length times for plotting stability
df_km$time[df_km$time == 0] <- 0.5

# --- OVERALL Kaplan–Meier
fit_all <- survfit(Surv(time, event) ~ 1, data = df_km)

plot(fit_all,
     xlab = "Days since admission",
     ylab = "In-hospital survival probability",
     main = "In-hospital Survival (Kaplan–Meier)",
     conf.int = TRUE,
     mark.time = TRUE)

# --- BY-SEX Kaplan–Meier (colored) + log-rank
# Keep clear Male/Female labels only
df_km$demog_sex <- trimws(df_km$demog_sex)
df_km_sex <- subset(df_km, demog_sex %in% c("Male", "Female"))

# Fix factor order (so colors map predictably)
df_km_sex$demog_sex <- factor(df_km_sex$demog_sex, levels = c("Male", "Female"))

fit_sex <- survfit(Surv(time, event) ~ demog_sex, data = df_km_sex)

cols <- c("Male" = "steelblue", "Female" = "tomato")

plot(fit_sex,
     xlab = "Days since admission",
     ylab = "In-hospital survival probability",
     main = "In-hospital Survival by Sex (Kaplan–Meier)",
     conf.int = FALSE,   # set TRUE if you want per-curve CIs
     lwd = 2,
     mark.time = TRUE,
     col = cols[levels(df_km_sex$demog_sex)])

legend("bottomleft",
       legend = names(cols),
       col = unname(cols),
       lwd = 2, bty = "n",
       title = "Sex")

# Log-rank test
logrank <- survdiff(Surv(time, event) ~ demog_sex, data = df_km_sex)
print(logrank)
