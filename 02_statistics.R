# =============================================================================
#  02_statistics.R  —  Descriptive statistics for all subjects
#  Student Academic Statistics Project
#  UID: 25BCD10313  |  Section: BCD-4B
# =============================================================================

cat("--- [2/4] Computing descriptive statistics ---\n")

# Score columns only
scores <- students[, c("Math", "Science", "English", "History")]

# ------------------------------------------------------------------
# 2.1  Built-in summary (5-number summary + mean)
# ------------------------------------------------------------------
cat("\n>> summary() — five-number summary per subject:\n")
print(summary(scores))

# ------------------------------------------------------------------
# 2.2  Individual statistics
# ------------------------------------------------------------------
cat("\n>> Mean per subject:\n")
print(round(sapply(scores, mean), 2))

cat("\n>> Median per subject:\n")
print(sapply(scores, median))

cat("\n>> Standard Deviation:\n")
print(round(sapply(scores, sd), 4))

cat("\n>> Variance:\n")
print(round(sapply(scores, var), 4))

cat("\n>> Minimum score:\n")
print(sapply(scores, min))

cat("\n>> Maximum score:\n")
print(sapply(scores, max))

cat("\n>> Range (Max - Min):\n")
print(sapply(scores, function(x) diff(range(x))))

cat("\n>> Q1 (25th percentile):\n")
print(sapply(scores, function(x) quantile(x, 0.25)))

cat("\n>> Q3 (75th percentile):\n")
print(sapply(scores, function(x) quantile(x, 0.75)))

cat("\n>> IQR (Interquartile Range):\n")
print(sapply(scores, IQR))

# ------------------------------------------------------------------
# 2.3  Combined stats table
# ------------------------------------------------------------------
stats_table <- data.frame(
  Subject  = names(scores),
  Mean     = round(sapply(scores, mean),   2),
  Median   = sapply(scores, median),
  Std_Dev  = round(sapply(scores, sd),     4),
  Variance = round(sapply(scores, var),    4),
  Min      = sapply(scores, min),
  Max      = sapply(scores, max),
  Range    = sapply(scores, function(x) diff(range(x))),
  Q1       = sapply(scores, function(x) quantile(x, 0.25)),
  Q3       = sapply(scores, function(x) quantile(x, 0.75)),
  IQR      = sapply(scores, IQR),
  row.names = NULL
)

cat("\n>> Combined descriptive statistics table:\n")
print(stats_table)

# ------------------------------------------------------------------
# 2.4  Class-wide overall statistics (across all subjects combined)
# ------------------------------------------------------------------
all_scores <- unlist(scores)

cat("\n>> Overall class statistics (all subjects combined):\n")
cat("   Total data points :", length(all_scores), "\n")
cat("   Overall Mean      :", round(mean(all_scores),   2), "\n")
cat("   Overall Median    :", median(all_scores),            "\n")
cat("   Overall Std Dev   :", round(sd(all_scores),     4), "\n")
cat("   Overall Min       :", min(all_scores),               "\n")
cat("   Overall Max       :", max(all_scores),               "\n")

# Make stats available globally
assign("stats_table",   stats_table,   envir = .GlobalEnv)
assign("scores",        scores,        envir = .GlobalEnv)
assign("all_scores",    all_scores,    envir = .GlobalEnv)

cat("\n")
