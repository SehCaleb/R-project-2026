# =============================================================================
#  04_advanced_analysis.R  —  Rankings, topper, correlation, performance flags
#  Student Academic Statistics Project
#  UID: 25BCD10313  |  Section: BCD-4B
# =============================================================================

cat("--- [4/4] Advanced analysis ---\n")

# ------------------------------------------------------------------
# 4.1  Rank students by average score
# ------------------------------------------------------------------
students_ranked <- students %>%
  arrange(desc(Average)) %>%
  mutate(Rank = row_number()) %>%
  select(Rank, Name, Math, Science, English, History, Average, Grade, Status)

cat("\n>> Student Rankings (highest to lowest average):\n")
print(students_ranked)

# ------------------------------------------------------------------
# 4.2  Class topper & lowest scorer
# ------------------------------------------------------------------
topper <- students[which.max(students$Average), ]
lowest <- students[which.min(students$Average), ]

cat("\n>> Class Topper:\n")
cat("   Name   :", topper$Name, "\n")
cat("   Average:", topper$Average, "\n")
cat("   Grade  :", as.character(topper$Grade), "\n")

cat("\n>> Lowest Scorer:\n")
cat("   Name   :", lowest$Name, "\n")
cat("   Average:", lowest$Average, "\n")
cat("   Grade  :", as.character(lowest$Grade), "\n")

# ------------------------------------------------------------------
# 4.3  Subject-level insights
# ------------------------------------------------------------------
subject_means <- colMeans(students[, 2:5])

cat("\n>> Class average per subject:\n")
print(round(subject_means, 2))

cat("\n>> Best subject  :", names(which.max(subject_means)),
    "->", round(max(subject_means), 2), "\n")
cat(">> Weakest subject:", names(which.min(subject_means)),
    "->", round(min(subject_means), 2), "\n")

# ------------------------------------------------------------------
# 4.4  Students below and above the class average
# ------------------------------------------------------------------
class_mean <- mean(students$Average)
cat("\n>> Class average (overall):", round(class_mean, 2), "\n")

above_avg <- students %>%
  filter(Average >= class_mean) %>%
  select(Name, Average, Grade)

below_avg <- students %>%
  filter(Average < class_mean) %>%
  select(Name, Average, Grade)

cat("\n>> Students ABOVE class average (", nrow(above_avg), "):\n", sep = "")
print(above_avg)

cat("\n>> Students BELOW class average (", nrow(below_avg), "):\n", sep = "")
print(below_avg)

# ------------------------------------------------------------------
# 4.5  Per-student: which subject is their strongest / weakest?
# ------------------------------------------------------------------
cat("\n>> Individual strengths & weaknesses:\n")

student_sw <- students %>%
  rowwise() %>%
  mutate(
    Strongest = names(which.max(c(Math = Math, Science = Science,
                                  English = English, History = History))),
    Weakest   = names(which.min(c(Math = Math, Science = Science,
                                  English = English, History = History)))
  ) %>%
  ungroup() %>%
  select(Name, Average, Strongest, Weakest)

print(student_sw)

# ------------------------------------------------------------------
# 4.6  Correlation matrix
# ------------------------------------------------------------------
cor_matrix <- round(cor(students[, 2:5]), 4)

cat("\n>> Correlation matrix (Pearson r):\n")
print(cor_matrix)

# Most and least correlated pair
cor_vals <- as.data.frame(as.table(cor_matrix))
cor_vals <- cor_vals[as.character(cor_vals$Var1) < as.character(cor_vals$Var2), ]
cor_vals <- cor_vals[order(-abs(cor_vals$Freq)), ]

cat("\n>> Strongest correlation :", as.character(cor_vals$Var1[1]),
    "&", as.character(cor_vals$Var2[1]),
    "->  r =", cor_vals$Freq[1], "\n")
cat(">> Weakest  correlation  :", as.character(cor_vals$Var1[nrow(cor_vals)]),
    "&", as.character(cor_vals$Var2[nrow(cor_vals)]),
    "->  r =", cor_vals$Freq[nrow(cor_vals)], "\n")

# ------------------------------------------------------------------
# 4.7  Grade distribution summary
# ------------------------------------------------------------------
cat("\n>> Grade distribution:\n")
grade_summary <- students %>%
  group_by(Grade) %>%
  summarise(
    Count      = n(),
    Percentage = round(n() / nrow(students) * 100, 1),
    Avg_Score  = round(mean(Average), 2),
    .groups    = "drop"
  ) %>%
  arrange(desc(Grade))

print(grade_summary)

# ------------------------------------------------------------------
# 4.8  Pass / Fail summary
# ------------------------------------------------------------------
cat("\n>> Pass / Fail summary:\n")
pass_fail <- students %>%
  group_by(Status) %>%
  summarise(Count = n(), .groups = "drop")
print(pass_fail)

# ------------------------------------------------------------------
# 4.9  Export summary to CSV
# ------------------------------------------------------------------
write.csv(students_ranked, "output/student_rankings.csv",    row.names = FALSE)
write.csv(stats_table,     "output/descriptive_stats.csv",   row.names = FALSE)
write.csv(grade_summary,   "output/grade_distribution.csv",  row.names = FALSE)
write.csv(as.data.frame(cor_matrix), "output/correlation_matrix.csv")

cat("\n>> CSV exports saved to /output\n\n")
