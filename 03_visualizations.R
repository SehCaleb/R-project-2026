# =============================================================================
#  03_visualizations.R  —  Six ggplot2 visualizations
#  Student Academic Statistics Project
#  UID: 25BCD10313  |  Section: BCD-4B
# =============================================================================

cat("--- [3/4] Generating visualizations ---\n")

# Shared theme for all plots
project_theme <- theme_minimal(base_size = 13) +
  theme(
    plot.title      = element_text(face = "bold", size = 15, color = "#1B3A6B", hjust = 0.5),
    plot.subtitle   = element_text(size = 11, color = "#2E86AB", hjust = 0.5),
    axis.title      = element_text(color = "#1B3A6B", face = "bold"),
    axis.text       = element_text(color = "#333333"),
    legend.title    = element_text(face = "bold", color = "#1B3A6B"),
    panel.grid.major = element_line(color = "#EBF4FA"),
    panel.grid.minor = element_blank(),
    plot.margin     = margin(15, 15, 15, 15)
  )

# Colour palettes (no green)
subject_colors <- c(Math = "#1B3A6B", Science = "#2E86AB", English = "#5BAFD6", History = "#A8D5EA")
student_colors <- c("#1B3A6B","#2E86AB","#5BAFD6","#A8D5EA",
                    "#0D2447","#3A9CC4","#1A5276","#154360","#2471A3","#7FB3D3")

# =============================================================================
# PLOT 1 — Bar Chart: Average Score per Student
# =============================================================================
cat("    Saving plot 1/6: Bar Chart — Average scores...\n")

p1 <- ggplot(students, aes(x = reorder(Name, -Average), y = Average, fill = Name)) +
  geom_bar(stat = "identity", width = 0.7, show.legend = FALSE) +
  geom_text(aes(label = round(Average, 1)), vjust = -0.5, size = 3.8,
            fontface = "bold", color = "#1B3A6B") +
  scale_fill_manual(values = student_colors) +
  scale_y_continuous(limits = c(0, 105), expand = c(0, 0)) +
  labs(
    title    = "Student Average Scores",
    subtitle = "Sorted from highest to lowest average",
    x        = "Student Name",
    y        = "Average Score (out of 100)"
  ) +
  project_theme

ggsave("plots/01_bar_average_scores.png", plot = p1, width = 10, height = 6, dpi = 150)

# =============================================================================
# PLOT 2 — Line Chart: Class Average by Subject
# =============================================================================
cat("    Saving plot 2/6: Line Chart — Class average by subject...\n")

class_avg <- colMeans(students[, 2:5])
subject_df <- data.frame(
  Subject = factor(names(class_avg), levels = names(class_avg)),
  Average = as.numeric(class_avg)
)

p2 <- ggplot(subject_df, aes(x = Subject, y = Average, group = 1)) +
  geom_line(color = "#2E86AB", linewidth = 1.8) +
  geom_point(size = 6, shape = 21, fill = "white",
             color = "#1B3A6B", stroke = 2.5) +
  geom_text(aes(label = round(Average, 1)), vjust = -1.4,
            size = 4.2, fontface = "bold", color = "#1B3A6B") +
  scale_y_continuous(limits = c(60, 100)) +
  labs(
    title    = "Class Average Score by Subject",
    subtitle = "Mean score across all 10 students per subject",
    x        = "Subject",
    y        = "Class Average Score"
  ) +
  project_theme

ggsave("plots/02_line_class_average.png", plot = p2, width = 9, height = 6, dpi = 150)

# =============================================================================
# PLOT 3 — Histogram: Distribution of All Scores
# =============================================================================
cat("    Saving plot 3/6: Histogram — Score distribution...\n")

hist_df <- data.frame(Score = all_scores)

p3 <- ggplot(hist_df, aes(x = Score)) +
  geom_histogram(bins = 10, fill = "#2E86AB", color = "white",
                 linewidth = 0.6, alpha = 0.9) +
  geom_vline(aes(xintercept = mean(Score)), color = "#1B3A6B",
             linetype = "dashed", linewidth = 1.2) +
  annotate("text", x = mean(all_scores) + 1.5, y = 7.5,
           label = paste("Mean =", round(mean(all_scores), 1)),
           color = "#1B3A6B", fontface = "bold", hjust = 0, size = 3.8) +
  labs(
    title    = "Distribution of All Subject Scores",
    subtitle = "Dashed line shows the overall mean",
    x        = "Score",
    y        = "Frequency"
  ) +
  project_theme

ggsave("plots/03_histogram_score_distribution.png", plot = p3, width = 9, height = 6, dpi = 150)

# =============================================================================
# PLOT 4 — Box Plot: Score Spread per Subject
# =============================================================================
cat("    Saving plot 4/6: Box Plot — Score spread per subject...\n")

long_df <- reshape2::melt(
  students[, 1:5],
  id.vars      = "Name",
  variable.name = "Subject",
  value.name    = "Score"
)

p4 <- ggplot(long_df, aes(x = Subject, y = Score, fill = Subject)) +
  geom_boxplot(alpha = 0.85, outlier.color = "#1B3A6B",
               outlier.size = 3, outlier.shape = 8,
               color = "#1B3A6B", linewidth = 0.7) +
  scale_fill_manual(values = subject_colors) +
  stat_summary(fun = mean, geom = "point", shape = 23,
               size = 4, fill = "white", color = "#1B3A6B") +
  labs(
    title    = "Score Distribution per Subject",
    subtitle = "Diamond = mean  |  Whiskers = min/max  |  Box = IQR",
    x        = "Subject",
    y        = "Score"
  ) +
  project_theme +
  theme(legend.position = "none")

ggsave("plots/04_boxplot_per_subject.png", plot = p4, width = 9, height = 6, dpi = 150)

# =============================================================================
# PLOT 5 — Pie Chart: Grade Distribution
# =============================================================================
cat("    Saving plot 5/6: Pie Chart — Grade distribution...\n")

grade_counts <- as.data.frame(table(students$Grade))
colnames(grade_counts) <- c("Grade", "Count")
grade_counts <- grade_counts[grade_counts$Count > 0, ]   # drop empty grades
grade_counts$Pct   <- round(grade_counts$Count / sum(grade_counts$Count) * 100, 1)
grade_counts$Label <- paste0(grade_counts$Grade, "\n", grade_counts$Count,
                              " student(s)\n(", grade_counts$Pct, "%)")

pie_colors <- c(A = "#1B3A6B", B = "#2E86AB", C = "#5BAFD6", D = "#A8D5EA", F = "#D0E8F5")

p5 <- ggplot(grade_counts, aes(x = "", y = Count, fill = Grade)) +
  geom_bar(stat = "identity", width = 1, color = "white", linewidth = 1) +
  coord_polar(theta = "y", start = 0) +
  scale_fill_manual(values = pie_colors) +
  geom_text(aes(label = Label),
            position = position_stack(vjust = 0.5),
            color = "white", fontface = "bold", size = 3.8) +
  labs(
    title    = "Grade Distribution (by Average Score)",
    subtitle = "A ≥ 90  |  B 80–89  |  C 70–79  |  D 60–69  |  F < 60",
    fill     = "Grade"
  ) +
  theme_void() +
  theme(
    plot.title    = element_text(face = "bold", size = 15, color = "#1B3A6B",
                                 hjust = 0.5, margin = margin(b = 6)),
    plot.subtitle = element_text(size = 11, color = "#2E86AB", hjust = 0.5),
    legend.title  = element_text(face = "bold", color = "#1B3A6B")
  )

ggsave("plots/05_pie_grade_distribution.png", plot = p5, width = 8, height = 7, dpi = 150)

# =============================================================================
# PLOT 6 — Grouped Bar Chart: Subject Scores per Student
# =============================================================================
cat("    Saving plot 6/6: Grouped Bar Chart — Subject scores per student...\n")

p6 <- ggplot(long_df, aes(x = Name, y = Score, fill = Subject)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.75, color = "white",
           linewidth = 0.3) +
  scale_fill_manual(values = subject_colors) +
  scale_y_continuous(limits = c(0, 105), expand = c(0, 0)) +
  labs(
    title    = "Subject-wise Scores per Student",
    subtitle = "Side-by-side comparison across all four subjects",
    x        = "Student",
    y        = "Score",
    fill     = "Subject"
  ) +
  project_theme +
  theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 10))

ggsave("plots/06_grouped_bar_subject_scores.png", plot = p6, width = 13, height = 6, dpi = 150)

# =============================================================================
# BONUS — Correlation Heatmap
# =============================================================================
cat("    Saving bonus plot: Correlation heatmap...\n")

cor_matrix <- round(cor(scores), 2)

# Melt for ggplot2
cor_long <- reshape2::melt(cor_matrix)
colnames(cor_long) <- c("Var1", "Var2", "Correlation")

p7 <- ggplot(cor_long, aes(x = Var1, y = Var2, fill = Correlation)) +
  geom_tile(color = "white", linewidth = 0.8) +
  geom_text(aes(label = Correlation), size = 5, fontface = "bold",
            color = ifelse(cor_long$Correlation > 0.7, "white", "#1B3A6B")) +
  scale_fill_gradient2(
    low      = "#A8D5EA",
    mid      = "#2E86AB",
    high     = "#1B3A6B",
    midpoint = 0.7,
    limits   = c(0.4, 1),
    name     = "r"
  ) +
  labs(
    title    = "Correlation Matrix — Subject Scores",
    subtitle = "Values close to 1.0 indicate strong positive correlation"
  ) +
  project_theme +
  theme(
    axis.title   = element_blank(),
    axis.text    = element_text(size = 12, face = "bold", color = "#1B3A6B"),
    legend.position = "right"
  )

ggsave("plots/07_correlation_heatmap.png", plot = p7, width = 7, height = 6, dpi = 150)

cat("    All 7 plots saved to /plots\n\n")
