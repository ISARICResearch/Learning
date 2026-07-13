############################################################
# BLOCK 0: Helper (pretty separators in the Console)
############################################################
sep <- function(title) {
  cat("\n\n==================== ", title, " ====================\n", sep = "")
}

############################################################
# BLOCK 1: Load packages & dataset
############################################################
sep("BLOCK 1: Load packages & dataset")

library(dplyr)

# Read CSV from GitHub
df <- read.csv("https://raw.githubusercontent.com/EstebanGarciaG/Lectures/main/data/data_synth.csv")

# Quick preview
cat("Rows x Cols:", nrow(df), "x", ncol(df), "\n")
cat("Some columns:", paste(head(names(df), 10), collapse = ", "), "...\n\n")
print(head(df[, c("demog_age","dates_admdate","outco_date",
                  "adsym_fever","comor_hypertensi","demog_sex")], 5))

############################################################
# BLOCK 2: Clean types & compute length of stay (LOS)
############################################################
sep("BLOCK 2: Clean types & compute LOS")

# Convert age to numeric (some may be character)
df$demog_age <- suppressWarnings(as.numeric(df$demog_age))

# Convert date columns to Date objects
df$outco_date    <- as.Date(df$outco_date,    format = "%Y-%m-%d")
df$dates_admdate <- as.Date(df$dates_admdate, format = "%Y-%m-%d")

# Compute LOS (days)
df$outco_lengthofstay <- as.numeric(df$outco_date - df$dates_admdate)
lengthofstay <- df$outco_lengthofstay

# Show quick summaries
cat("\nSummary: age\n"); print(summary(df$demog_age))
cat("\nSummary: LOS (days)\n"); print(summary(lengthofstay))
cat("\nMissing LOS count:", sum(is.na(lengthofstay)), "\n")

############################################################
# BLOCK 3: Simple visualisations (histograms + boxplot)
############################################################
sep("BLOCK 3: Simple visualisations")

# 2 histograms (age & LOS)
op <- par(mfrow = c(2, 1))
hist(df$demog_age, breaks = 30, main = "Age distribution", xlab = "Age (years)")
hist(lengthofstay, breaks = 30, main = "Length of stay", xlab = "Days")
par(op)  # reset layout

# Boxplot of LOS
boxplot(lengthofstay,
        ylab = "Length of stay (days)",
        main = "Boxplot of LOS")

############################################################
# BLOCK 4: Bar plot — fever by sex (stacked %)
############################################################
sep("BLOCK 4: Fever by sex (stacked %)")

# Keep only rows with non-empty fever values
df_clean <- subset(df, adsym_fever != "", select = c(demog_sex, adsym_fever))

# Contingency table: sex x fever
tab <- table(df_clean$demog_sex, df_clean$adsym_fever)

# Convert to within-sex proportions (percent)
prop_tab <- round(100 * prop.table(tab, margin = 1), 1)
cat("\nProportions of fever by sex (%):\n"); print(prop_tab)

# Stacked barplot of proportions
op <- par(mar = c(5, 4, 4, 6))  # room for legend on the right
bp <- barplot(
  t(prop_tab),
  beside = FALSE,
  col = c("lightblue", "tomato"),
  ylim = c(0, 100),
  ylab = "Proportion (%)",
  xlab = "Sex",
  main = "Fever by sex (stacked %)"
)

# Add % labels inside bars
lbl_mat <- t(prop_tab)
y_mid <- apply(lbl_mat, 2, cumsum) - 0.5 * lbl_mat
text(x = rep(bp, each = nrow(lbl_mat)), y = as.vector(y_mid),
     labels = paste0(as.vector(lbl_mat), "%"))

legend("topright", inset = c(-0.25,0),
       legend = colnames(prop_tab),  # fever categories
       fill = c("lightblue","tomato"),
       xpd = TRUE, bty = "n")
par(op)

############################################################
# BLOCK 5: Create cleaned dataset for descriptive table
############################################################
sep("BLOCK 5: Create cleaned dataset for descriptive table")

# Keep only variables of interest
keep_vars <- c("demog_age", "outco_lengthofstay",
               "adsym_fever", "comor_hypertensi", "demog_sex")
df_subset <- df[, keep_vars]

# Helper to convert text to TRUE/FALSE, keep NA otherwise
to_logical <- function(x) ifelse(x %in% c("True","true"), TRUE,
                           ifelse(x %in% c("False","false"), FALSE, NA))

# Recode binary-like text
df_subset$adsym_fever      <- to_logical(df_subset$adsym_fever)
df_subset$comor_hypertensi <- to_logical(df_subset$comor_hypertensi)

# Ensure numeric for continuous
df_subset$demog_age <- suppressWarnings(as.numeric(df_subset$demog_age))
df_subset$outco_lengthofstay <- suppressWarnings(as.numeric(df_subset$outco_lengthofstay))

# Drop rows with missing values in key fields
df_subset <- subset(
  df_subset,
  !is.na(demog_age) & !is.na(outco_lengthofstay) &
  !is.na(adsym_fever) & !is.na(comor_hypertensi) &
  demog_sex != ""
)

# Tidy sex as factor
df_subset$demog_sex <- factor(df_subset$demog_sex)

# Preview and size
cat("\nCleaned dataset preview:\n"); print(head(df_subset, 6))
cat("\nCleaned dataset dims (rows, cols):", dim(df_subset)[1], dim(df_subset)[2], "\n")

############################################################
# BLOCK 6: Build a simple descriptive "Table 1"
############################################################
sep("BLOCK 6: Descriptive table (Table 1-style)")

cont_vars <- c("demog_age", "outco_lengthofstay")
bin_vars  <- c("adsym_fever", "comor_hypertensi")

# Groups: overall + by sex
groups <- c("All", levels(df_subset$demog_sex))

descriptive_table <- data.frame(
  Variable = character(),
  Group    = character(),
  Summary  = character(),
  stringsAsFactors = FALSE
)

for (g in groups) {
  dat <- if (g == "All") df_subset else subset(df_subset, demog_sex == g)

  # Continuous: median (IQR) | n
  for (v in cont_vars) {
    x <- dat[[v]]
    x <- x[is.finite(x)]
    med <- median(x, na.rm = TRUE)
    q1  <- quantile(x, 0.25, na.rm = TRUE)
    q3  <- quantile(x, 0.75, na.rm = TRUE)
    n   <- length(x)
    descriptive_table <- rbind(descriptive_table, data.frame(
      Variable = v,
      Group    = g,
      Summary  = sprintf("%.1f (%.1f–%.1f) | %d", med, q1, q3, n),
      stringsAsFactors = FALSE
    ))
  }

  # Binary: count (%) | n
  for (v in bin_vars) {
    x <- dat[[v]]
    x <- x[!is.na(x)]
    n_yes    <- sum(x == TRUE)
    prop_yes <- 100 * mean(x == TRUE)
    n_total  <- length(x)
    descriptive_table <- rbind(descriptive_table, data.frame(
      Variable = v,
      Group    = g,
      Summary  = sprintf("%d (%.1f%%) | %d", n_yes, prop_yes, n_total),
      stringsAsFactors = FALSE
    ))
  }
}

# Markers (~ for continuous, * for binary)
descriptive_table$Variable <- ifelse(
  descriptive_table$Variable %in% cont_vars,
  paste0(descriptive_table$Variable, " ~: Median (IQR) | n"),
  paste0(descriptive_table$Variable, " *: Count (%) | n")
)

# Reshape to wide format (Table 1 style)
table_wide <- reshape(
  descriptive_table,
  idvar    = "Variable",
  timevar  = "Group",
  direction = "wide"
)

# Clean column names and print
names(table_wide) <- sub("^Summary\\.", "", names(table_wide))
cat("\nDescriptive table (wide):\n")
print(table_wide, row.names = FALSE)
