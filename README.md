# R-project-2026
# 📊 Student Academic Statistics — R Programming Project

**Name:** Seh Favour Caleb Talle  
**UID:** 25BCD10313  
**Section:** BCD-4B  

---

## Overview

This project analyses the academic performance of 10 students across four subjects — **Mathematics, Science, English, and History** — using the **R programming language**. It covers the full data analysis pipeline: data creation, descriptive statistics, visualizations, and advanced analytical insights.

---

## 📁 Project Structure

```
School_Project/
│
├── SchoolProject.R                        # Entry point — run this file
│
├── R/
│   ├── 00_setup.R                # Package installation & loading
│   ├── 01_dataset.R              # Dataset creation & preview
│   ├── 02_statistics.R           # Descriptive statistics
│   ├── 03_visualizations.R       # All ggplot2 charts (7 plots)
│   └── 04_advanced_analysis.R    # Rankings, correlation, insights
│
├── plots/                        # Generated PNG charts (auto-created)
│   ├── 01_bar_average_scores.png
│   ├── 02_line_class_average.png
│   ├── 03_histogram_score_distribution.png
│   ├── 04_boxplot_per_subject.png
│   ├── 05_pie_grade_distribution.png
│   ├── 06_grouped_bar_subject_scores.png
│   └── 07_correlation_heatmap.png
│
├── output/                       # Generated CSV exports (auto-created)
│   ├── student_rankings.csv
│   ├── descriptive_stats.csv
│   ├── grade_distribution.csv
│   └── correlation_matrix.csv
│
└── README.md
```

---

## 📦 Libraries Used

| Library | Purpose |
|---|---|
| `ggplot2` | Publication-quality visualizations (Grammar of Graphics) |
| `dplyr` | Data manipulation — filter, arrange, mutate, summarise |
| `reshape2` | Pivot data between wide and long format |
| `corrplot` | Correlation matrix visualization |
| `scales` | Axis label formatting helpers |
| `gridExtra` | Arrange multiple ggplot2 plots in one figure |

All packages are **automatically installed** if not already present when you run `main.R`.

---

## ▶️ How to Run

### Option 1 — RStudio
1. Open the project folder in RStudio.
2. Open `main.R`.
3. Click **Source** .

### Option 2 — R Console / Terminal
```r
setwd("/path/to/r_student_stats")
source("main.R")
```

### Option 3 — Command Line
```bash
Rscript main.R
```

---

## 📊 What the Project Covers

### 1. Dataset
- 10 students × 4 subjects (Math, Science, English, History)
- Derived columns: Average, Total, Grade (A–F), Pass/Fail status

### 2. Descriptive Statistics
| Statistic | Description |
|---|---|
| Mean | Average value across students |
| Median | Middle value (robust to outliers) |
| Standard Deviation | Spread around the mean |
| Variance | Squared spread |
| Min / Max | Lowest and highest scores |
| Range | Max − Min |
| Q1 / Q3 | 25th and 75th percentiles |
| IQR | Interquartile range (Q3 − Q1) |

### 3. Visualizations (7 charts)
| # | Chart | What it shows |
|---|---|---|
| 1 | Bar chart | Average score per student (sorted) |
| 2 | Line chart | Class average per subject |
| 3 | Histogram | Distribution of all scores + mean line |
| 4 | Box plot | Five-number summary per subject |
| 5 | Pie chart | Grade distribution (A/B/C/D/F) |
| 6 | Grouped bar | All four subject scores per student |
| 7 | Heatmap | Pearson correlation between subjects |

### 4. Advanced Analysis
- Students ranked by average score
- Class topper and lowest scorer identified
- Best and weakest subject highlighted
- Students above/below class average
- Per-student strongest and weakest subject
- Pearson correlation matrix with strongest/weakest pair
- Grade and pass/fail distribution summaries
- CSV exports to `/output`

---

## 📈 Sample Results

| Student | Average | Grade |
|---|---|---|
| Grace | 91.00 | A |
| Carol | 88.50 | B |
| Eve | 87.00 | B |
| Jack | 84.50 | B |
| Ivy | 82.25 | B |
| Bob | 82.00 | B |
| Henry | 80.75 | B |
| Alice | 78.75 | C |
| Frank | 72.50 | C |
| David | 71.00 | C |

**Class Topper:** Grace (91.00)  
**Best Subject:** Mathematics (83.10)  
**Strongest Correlation:** Math & History (r = 0.78)

---

## 🔑 Key Concepts

- **Mean** — Σx / n, the arithmetic average
- **Median** — middle value; robust to extreme scores
- **Standard Deviation** — √(Σ(x−μ)²/n), measures spread
- **IQR** — Q3 − Q1, the middle 50% of data; used to detect outliers
- **Correlation (r)** — linear relationship between −1 and +1; |r| > 0.7 is strong

---

## 📄 License

This project is submitted for academic purposes.  
**Department of Computer Science & Engineering — Academic Year 2024–25**

