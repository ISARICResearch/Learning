# Setup script: Install required packages for CREDO learning Quarto documents
# Run this script once to install all dependencies needed for the .qmd files

# List of required packages
required_packages <- c(
  "tidyverse",
  "stringi",
  "gtsummary",
  "quarto",
  "markdown",
  "gt",
  "knitr",
  "report"
)

# Check which packages are not installed
missing_packages <- required_packages[
  !sapply(required_packages, function(pkg) {
    requireNamespace(pkg, quietly = TRUE)
  })
]

# Install missing packages
if (length(missing_packages) > 0) {
  cat("Installing", length(missing_packages), "package(s)...\n")
  install.packages(missing_packages, repos = getOption("repos"))
  cat("Installation complete!\n")
} else {
  cat("All required packages are already installed.\n")
}

# Verify installation
cat("\nVerifying installations:\n")
for (pkg in required_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat("✓", pkg, "-", "installed \n")
  } else {
    cat("✗", pkg, "- FAILED TO INSTALL\n")
  }
}

# Render all course materials (Quarto documents and markdown documentation)
cat("\n========================================\n")
cat("Generating all course materials...\n")
cat("========================================\n")
source("renderer.R")
