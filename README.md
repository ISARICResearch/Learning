# CREDO Learning: Introduction to Statistics for Clinical Research

Open educational resources for clinical research, biostatistics, epidemiology, data science, and outbreak research. This repository contains comprehensive Quarto documents with practical examples, code demonstrations, and best practices for statistical analysis in clinical settings.

## Quick Start

### Setup & Generate All Course Materials (One Command)

Run this single command to install all dependencies and automatically generate PDF files for all course modules and reference documentation:

```r
source("setup_packages.R")
```

**What this does:**
1. ✅ Installs required packages (tidyverse, gtsummary, report, quarto, markdown, gt, knitr)
2. ✅ Verifies all installations with version info
3. ✅ **Automatically generates PDF files** from:
   - 8 Quarto course modules (`.qmd` files)
   - 9 Markdown reference guides (`.md` files)
4. ✅ Generates PDFs in their respective directories (ready to read immediately)

**Output:**
- Course material PDFs in: `Introduction-to-Statistics-for-Clinical-Research-main/`
- Reference guide PDFs in: root directory `./`

**That's it!** After running this script, all course materials are ready to use.

### Manual Rendering (Optional)

If you want to re-render specific files manually, use the standalone renderer script:

```r
source("renderer.R")
```

This renders all `.qmd` and `.md` files to PDF without reinstalling packages.

### Render Individual Documents

To render a single document manually:

```r
# Render a Quarto course module
quarto::quarto_render("Introduction-to-Statistics-for-Clinical-Research-main/1_Descriptive Statistics_CREDO.qmd", output_format = "pdf")

# Render a markdown guide
quarto::quarto_render("R_FUNCTIONS_GUIDE.md", output_format = "pdf")
```

---

## Course Materials Overview

All Quarto documents are located in `Introduction-to-Statistics-for-Clinical-Research-main/`. The course is organized sequentially, starting with **critical foundational modules** before building to advanced statistical methods.

---

## ⚠️ Start Here: Foundational Modules

These modules establish essential R programming and conceptual skills required for all subsequent statistics modules.

### 0. **Basic R Programming** (PREREQUISITE)
**File:** `Basic_R_Programming.qmd`

Essential R skills for statistical analysis in clinical research.

**Topics covered:**
- R fundamentals (objects, vectors, data frames)
- Functions and function calling
- Type expectations and parameter validation
- Calling functions: step-by-step procedure
- Common errors and debugging
- Type safety in clinical data processing
- Clinical research examples

**Why this matters:** 
- Functions are the foundation of all subsequent analysis
- Type mismatches cause silent wrong results (dangerous in clinical context)
- Understanding R prevents costly errors in data handling

**Related documentation:** See `R_FUNCTIONS_GUIDE.md` for comprehensive function reference with detailed type safety emphasis (611 lines)

---

### Key Reference: R Functions Guide
**File:** `R_FUNCTIONS_GUIDE.md` (611 lines)

Comprehensive R functions reference with critical type safety emphasis.

**Core concepts:**
- Function anatomy and calling conventions
- Type expectations (numeric, character, logical, vector, data frame, list, NULL)
- Type mismatch: Common errors and silent wrong results
- Type checking and validation for clinical safety
- Parameter expectations and validation
- Best practices for calling functions safely

**Why this matters:**
- Silent failures are dangerous in clinical research
- Functions expect specific types (not optional)
- Wrong types can produce medically incorrect results without error messages
- Validation prevents dosing errors and data integrity problems

**Clinical context examples:**
- Medication dosing calculations
- Patient data processing
- Lab value calculations
- Data integrity verification

---

### Core Statistics Modules (CREDO Enhanced)

#### 1. **Descriptive Statistics** 
**File:** `1_Descriptive Statistics_CREDO.qmd`

Foundational concepts for summarizing data in clinical research.

**Topics covered:**
- Data types and exploration (continuous, categorical, binary)
- Missing data handling and reporting
- Summary statistics (mean, median, standard deviation, IQR)
- Visualizing distributions (histograms, box plots)
- Stratified analysis and group comparisons
- Best practices for exploratory data analysis

**Key callouts:** Importance of data inspection, missing data risks, outlier detection, proportions vs. counts, summary statistics selection

**Code examples:** Real-world clinical datasets, patient demographics, lab values

---

#### 2. **Populations and Samples**
**File:** `2_Populations and Samples.qmd`

Understanding sampling designs and population inference.

**Topics covered:**
- Population vs. sample concepts
- Sampling methods and bias
- Sample size calculations
- Representativeness and generalizability

---

#### 3. **Probability and Confidence Intervals**
**File:** `3_Probability and Confidence Intervals.qmd`

Quantifying uncertainty in clinical estimates.

**Topics covered:**
- Probability distributions (normal, binomial, t-distribution)
- Central limit theorem
- Confidence intervals (interpretation and calculation)
- Standard error and margin of error

---

#### 4. **Hypothesis Testing and Rank Tests**
**Files:** 
- `4.1_Hypothesis Testing and Rank Tests.qmd` (Part 1)
- `4.2_Hypothesis Testing and Rank Tests.qmd` (Part 2)

Statistical testing for clinical hypotheses.

**Topics covered:**
- Hypothesis testing framework (null/alternative hypotheses)
- Type I and Type II errors, power
- t-tests, ANOVA, chi-squared tests
- Rank-based tests (Mann-Whitney U, Wilcoxon signed-rank, Kruskal-Wallis)
- Multiple comparisons and corrections

---

#### 5. **Linear and Logistic Regression** ⭐ ENHANCED
**File:** `5_Linear and Logistic Regression_CREDO.qmd`

Modeling relationships between variables.

**Topics covered:**
- Linear regression (simple and multiple)
- Model assumptions and diagnostics
- Logistic regression for binary outcomes
- Odds ratios and model interpretation
- Model comparison and goodness-of-fit

**Enhancements:**
- 10 strategic callouts on regression best practices
- New Output 4.5: Statistical Model Comparison with side-by-side metrics
- Emphasis on clinical vs. statistical significance
- Confounding and covariate adjustment
- Outlier impact and removal decisions

**Key callouts:** Regression assumptions, visual data inspection, coefficient interpretation, correlation vs. causation, outlier handling, model comparison

---

#### 6. **Survival Analysis** ⭐ ENHANCED
**File:** `6_Survival Analysis_CREDO.qmd`

Analyzing time-to-event outcomes with censoring.

**Topics covered:**
- Censoring and time-to-event data
- Kaplan-Meier survival curves
- Log-rank test for group comparisons
- Cox proportional hazards model (univariable and multivariable)
- Hazard ratios and interpretation
- Proportional hazards assumption checking

**Enhancements:**
- 8 strategic callouts on survival analysis best practices
- Improved document structure with consistent heading hierarchy
- Clear progression: concept → data setup → visualization → testing → adjustment
- Clinical context and interpretation guidance

**Key callouts:** Censoring definition, data preparation, Kaplan-Meier features, Cox output interpretation, confounding adjustment, hazard ratio interpretation

---

## Supporting Documentation

### Reference Guides

| File | Purpose |
|------|---------|
| `PIPE_OPERATORS_GUIDE.md` | Base R pipe `\|>` vs. magrittr pipe `%>%` comparison, with clinical examples |
| `R_FUNCTIONS_GUIDE.md` | Comprehensive R functions reference with type safety and parameter validation (611 lines) |
| `CLINICAL_RESEARCH_STATISTICS_COMPLETE.md` | Complete enhancement summary across all modules |

### Analysis Summaries

| File | Purpose |
|------|---------|
| `OUTLIER_ANALYSIS_SUMMARY.md` | Outlier detection and removal methodology |
| `ANOVA_COMPARISON_SUMMARY.md` | Statistical model comparison techniques |
| `SURVIVAL_ANALYSIS_ENHANCEMENTS.md` | Detailed survival analysis improvements |
| `FUNCTIONS_EXPANSION_SUMMARY.md` | Type safety and parameter validation expansion |

---

## How to Use These Materials

### For Instructors

1. **Run `source("setup_packages.R")`** once to generate all PDFs
2. **Share generated PDFs** with students or use directly in your course
3. **Modify source documents** (`.qmd` and `.md` files) to customize content
4. **Render modified documents** using `source("renderer.R")` to generate updated PDFs
5. **Extract callouts** from course modules for emphasis on key concepts
6. **Use comparison tables** (e.g., model comparison in Module 5) for teaching statistical decision-making

### For Students

1. **Run `source("setup_packages.R")`** to install all dependencies and generate all course materials
2. **PDFs will be ready immediately** in two locations:
   - Course modules: `Introduction-to-Statistics-for-Clinical-Research-main/` directory
   - Reference guides: root directory `./`
3. **Start with Basic R Programming module** — Covers essential R skills and type safety
4. **Consult R_FUNCTIONS_GUIDE.pdf** — Deep dive on functions and parameter validation
5. **Work through statistics modules sequentially** (1 → 6) for comprehensive foundation
6. **Execute code chunks from source `.qmd` files** to see output; modify and experiment
7. **Review callouts** in PDFs for best practices and common pitfalls
8. **Study clinical examples** to understand real-world application

### For Self-Study

1. **Run `source("setup_packages.R")`** — One-time setup to install packages and generate all materials
2. **Start with Basic R Programming PDF** (prerequisite) for essential R foundations
3. **Study R_FUNCTIONS_GUIDE.pdf** for deep understanding of functions and type safety
4. **Progress through statistics module PDFs** (1 → 6) at your own pace
5. **Reference PDF guides** for deeper dives (pipe operators, survival analysis, outlier detection)
6. **Open corresponding `.qmd` source files** to run code examples and experiment

---

## File Organization

```
credo-learning/
├── README.md (this file)
├── setup_packages.R (run once: installs packages + generates all PDFs)
├── renderer.R (optional: re-render files manually)
├── LICENSE
├── [Generated PDFs from markdown guides - created by setup_packages.R]
│   ├── PIPE_OPERATORS_GUIDE.pdf
│   ├── R_FUNCTIONS_GUIDE.pdf
│   ├── CLINICAL_RESEARCH_STATISTICS_COMPLETE.pdf
│   └── [other documentation PDFs]
├── Introduction-to-Statistics-for-Clinical-Research-main/
│   ├── 0_Basic_R_Programming.qmd ⭐ START HERE (prerequisite)
│   ├── 1_Descriptive Statistics_CREDO.qmd ⭐ ENHANCED
│   ├── 2_Populations and Samples.qmd
│   ├── 3_Probability and Confidence Intervals.qmd
│   ├── 4.1_Hypothesis Testing and Rank Tests.qmd
│   ├── 4.2_Hypothesis Testing and Rank Tests.qmd
│   ├── 5_Linear and Logistic Regression_CREDO.qmd ⭐ ENHANCED
│   ├── 6_Survival Analysis_CREDO.qmd ⭐ ENHANCED
│   ├── [Generated PDFs from course modules]
│   ├── 0_Basic_R_Programming.pdf
│   ├── 1_Descriptive-Statistics_CREDO.pdf
│   ├── [other module PDFs]
│   └── *.R (companion R scripts for each module)
├── PIPE_OPERATORS_GUIDE.md
├── R_FUNCTIONS_GUIDE.md
├── CLINICAL_RESEARCH_STATISTICS_COMPLETE.md
└── [other reference documentation]
```

---

## Key Features

✅ **One-Command Setup** — Run `source("setup_packages.R")` to install all dependencies and generate all course materials  
✅ **Clinical Context** — All examples use realistic clinical research scenarios  
✅ **Best Practices** — 30+ strategic callouts highlighting key concepts and pitfalls  
✅ **Executable Code** — Every code chunk is fully functional and tested  
✅ **Statistical Rigor** — Emphasis on assumptions, diagnostics, and proper interpretation  
✅ **Type Safety** — R function guide emphasizes type expectations and validation  
✅ **Comprehensive** — 8 sequential modules covering R programming fundamentals through survival analysis  
✅ **PDF Ready** — All course materials and reference guides automatically generated as PDFs

---

## Requirements

- **R** ≥ 4.1 (for base pipe `|>`)
- **Quarto** ≥ 1.3
- **Packages** (installed via `setup_packages.R`):
  - tidyverse, gtsummary, report, quarto, markdown, gt, knitr

---

## License

See LICENSE file for terms and conditions.

---

## Getting Help

- **Review callouts in PDFs** — Each course module PDF contains strategic callouts highlighting best practices
- **Consult reference PDFs** — Reference guides (PIPE_OPERATORS_GUIDE.pdf, R_FUNCTIONS_GUIDE.pdf) provide quick answers
- **View source `.qmd` files** — Open corresponding `.qmd` files to run and modify code examples
- **Check module documentation** — Each module directory contains a README with module-specific guidance

---

## Contributing

To enhance these materials:
1. Modify source files (`.qmd` for course modules, `.md` for documentation)
2. Test all code examples thoroughly before finalizing
3. Add clinical context where helpful
4. Run `source("renderer.R")` to generate updated PDFs locally
5. Update this README with new modules or features
