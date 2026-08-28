# CREDO Learning: Introduction to Statistics for Clinical Research

Open educational resources for clinical research, biostatistics, epidemiology, data science, and outbreak research. This repository contains comprehensive Quarto documents with practical examples, code demonstrations, and best practices for statistical analysis in clinical settings.

## Quick Start

### 0. Getting a Copy of the Repository

As described in the [contributions guide](https://github.com/ISARICResearch/Learning/blob/main/CONTRIBUTING.md) contributors need to have a copy of the repository either as a clone or a fork.

The repository can be [cloned](https://git-scm.com/docs/git-clone) with Git, for example, over HTTPS:
```shell
git clone git+https://github.com/ISARICResearch/Learning
```
or over SSH:
```shell
git clone git+ssh://git@github.com/ISARICResearch/Learning
```

> [!Note]
If using SSH consult the [GitHub SSH guide](https://docs.github.com/authentication/connecting-to-github-with-ssh) for more information on creating and setting up SSH keys to connect to your GitHub account.

Alternatively, if you're developing in a Git-integrated IDE such as VS Code then cloning can be performed within the IDE.

The repository can also be [forked](https://docs.github.com/en/pull-requests/how-tos/work-with-forks/fork-a-repo), if a fork is preferred, using the Fork option on the GitHub repository home page.


### 1. Install Dependencies

Before running any Quarto documents, install required packages:

```r
source("setup_packages.R")
```

**Packages installed:**
- **tidyverse** — Data manipulation and visualization
- **gtsummary** — Publication-quality summary tables
- **report** — Automated statistical reporting
- **quarto** — Quarto document rendering
- **markdown** — Markdown processing
- **gt** — Grammar of tables for formatted table output
- **knitr** — Dynamic document generation

The script checks for existing installations and only installs missing packages.

### 2. Render Quarto Documents

Navigate to the `Introduction-to-Statistics-for-Clinical-Research-main/` directory and render any Quarto document (`.qmd`):

R:

```r
quarto::quarto_render("Introduction-to-Statistics-for-Clinical-Research-main/1_Descriptive Statistics_CREDO.qmd")
```

While in RStudio, you can also click on the `Preview/Render` button to process the file.
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

1. **Render individual modules** as needed in your course
2. **Modify code examples** to match your clinical context
3. **Extract callouts** for emphasis on key concepts
4. **Use comparison tables** (e.g., model comparison in Module 5) for teaching statistical decision-making

### For Students

1. **Run the setup script** to install dependencies
2. **Start with Basic R Programming module** — Covers essential R skills and type safety
3. **Consult R_FUNCTIONS_GUIDE.md** — Deep dive on functions and parameter validation
4. **Work through statistics modules sequentially** (1 → 6) for comprehensive foundation
5. **Execute code chunks** to see output; modify and experiment
6. **Review callouts** for best practices and common pitfalls
7. **Study clinical examples** to understand real-world application

### For Self-Study

1. **Start with Basic R Programming** (prerequisite) for essential R foundations
2. **Study R_FUNCTIONS_GUIDE.md** for deep understanding of functions and type safety
3. **Progress through statistics modules** (1 → 6) at your own pace
4. **Use supporting documentation** for deeper dives (pipe operators, survival analysis)
5. **Reference guides** for syntax and implementation details

---

## File Organization

```
credo-learning/
├── README.md (this file)
├── setup_packages.R (run this first!)
├── R_FUNCTIONS_GUIDE.md (comprehensive functions reference — read after Basic R Programming)
├── LICENSE
├── Introduction-to-Statistics-for-Clinical-Research-main/
│   ├── Basic_R_Programming.qmd ⭐ START HERE (prerequisite)
│   ├── 1_Descriptive Statistics_CREDO.qmd ⭐ ENHANCED
│   ├── 2_Populations and Samples.qmd
│   ├── 3_Probability and Confidence Intervals.qmd
│   ├── 4.1_Hypothesis Testing and Rank Tests.qmd
│   ├── 4.2_Hypothesis Testing and Rank Tests.qmd
│   ├── 5_Linear and Logistic Regression_CREDO.qmd ⭐ ENHANCED
│   ├── 6_Survival Analysis_CREDO.qmd ⭐ ENHANCED
│   ├── *.html (rendered outputs)
│   ├── *_files/ (Quarto support directories)
│   └── README.md (module-level documentation)
├── PIPE_OPERATORS_GUIDE.md
├── CLINICAL_RESEARCH_STATISTICS_COMPLETE.md
└── [other documentation files]
```

---

## Key Features

✅ **Clinical Context** — All examples use realistic clinical research scenarios  
✅ **Best Practices** — 30+ strategic callouts highlighting key concepts and pitfalls  
✅ **Executable Code** — Every code chunk is fully functional and tested  
✅ **Statistical Rigor** — Emphasis on assumptions, diagnostics, and proper interpretation  
✅ **Type Safety** — R function guide emphasizes type expectations and validation  
✅ **Comprehensive** — 7 sequential modules covering statistics fundamentals to survival analysis

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

- Review the **callouts** in each Quarto document for best practices
- Consult `PIPE_OPERATORS_GUIDE.md` for pipe syntax questions
- Reference `R_FUNCTIONS_GUIDE.md` for function calling and type safety
- Check individual module READMEs for module-specific guidance

---

## Maintainers

Repository members who manage access, maintenance and change management issues are listed below:

- Esteban Garcia-Gallo - esteban.garcia@ndm.ox.ac.uk
- Sara Duque Vallejo - sara.duquevallejo@ndm.ox.ac.uk
- Sandeep Murthy - sandeep.murthy@ndm.ox.ac.uk

## Contributors

- Esteban Garcia-Gallo - esteban.garcia@ndm.ox.ac.uk
- Ibrahim Kwaku Duah - kwakuduah@kccr.de
- Robert Asampong - r.asampong@kccr.de

---

## Contributing

A general set of contributions guidelines and basic workflow is described [here](https://github.com/ISARICResearch/Learning/blob/main/CONTRIBUTING.md).

Additional aspects include those listed below.

1. Test all code examples thoroughly
2. Add clinical context where helpful
3. Document any structural changes
4. Ensure git tracking is clean (HTML files in `.gitignore`)
5. Update this README with new modules or features
