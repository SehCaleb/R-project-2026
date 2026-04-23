# =============================================================================
#  00_setup.R  —  Package installation & loading
#  Student Academic Statistics Project
#  UID: 25BCD10313  |  Section: BCD-4B
# =============================================================================

cat("--- [0/4] Setting up packages ---\n")

# List of required packages
required_packages <- c("ggplot2", "dplyr", "reshape2", "corrplot", "scales", "gridExtra")

# Install any that are missing
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Installing package:", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
  }
}

invisible(sapply(required_packages, install_if_missing))

# Load all packages
suppressPackageStartupMessages({
  library(ggplot2)    # Beautiful, layered visualizations
  library(dplyr)      # Data manipulation verbs (filter, arrange, mutate…)
  library(reshape2)   # Reshape data between wide and long format
  library(corrplot)   # Correlation matrix visualization
  library(scales)     # Axis scaling helpers for ggplot2
  library(gridExtra)  # Arrange multiple ggplot2 plots on one page
})

# Ensure the plots output folder exists
if (!dir.exists("plots")) dir.create("plots")

cat("    Packages loaded successfully.\n\n")
