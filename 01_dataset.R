# =============================================================================
#  01_dataset.R  —  Create and explore the student dataset
#  Student Academic Statistics Project
#  UID: 25BCD10313  |  Section: BCD-4B
# =============================================================================

cat("--- [1/4] Creating dataset ---\n")

# ------------------------------------------------------------------
# 1.1  Raw dataset
# ------------------------------------------------------------------
students <- data.frame(
  Name    = c("Alice", "Bob",   "Carol", "David", "Eve",
              "Frank", "Grace", "Henry", "Ivy",   "Jack"),
  Math    = c(78, 85, 92, 67, 88, 74, 95, 82, 79, 91),
  Science = c(82, 79, 88, 72, 85, 68, 90, 88, 83, 76),
  English = c(75, 88, 84, 80, 92, 71, 87, 79, 86, 83),
  History = c(80, 76, 90, 65, 83, 77, 92, 74, 81, 88),
  stringsAsFactors = FALSE
)

# ------------------------------------------------------------------
# 1.2  Derived columns
# ------------------------------------------------------------------

# Average score per student (mean of the four subjects)
students$Average <- round(rowMeans(students[, 2:5]), 2)

# Total marks per student
students$Total <- rowSums(students[, 2:5])

# Letter grade based on average
students$Grade <- cut(
  students$Average,
  breaks = c(0, 60, 70, 80, 90, 100),
  labels = c("F", "D", "C", "B", "A"),
  right  = TRUE,
  include.lowest = TRUE
)

# Pass / Fail (pass if Average >= 60)
students$Status <- ifelse(students$Average >= 60, "Pass", "Fail")

# ------------------------------------------------------------------
# 1.3  Preview the dataset
# ------------------------------------------------------------------
cat("\n>> Full student dataset:\n")
print(students)

cat("\n>> Dataset dimensions:", nrow(students), "students,", ncol(students), "columns\n")
cat(">> Column names:", paste(names(students), collapse = ", "), "\n\n")

# Make the data frame available globally so other scripts can use it
assign("students", students, envir = .GlobalEnv)
