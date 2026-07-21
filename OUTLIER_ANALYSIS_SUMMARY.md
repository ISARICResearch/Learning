# Linear and Logistic Regression - Outlier Analysis Enhancement

## Problem Fixed
The document was rendering with an error because code in Output 3 referenced `lm_fit`, which was defined later in the document.

## Solution
Reorganized the outputs so that code dependencies execute in the correct order:

### Execution Order (Fixed)
1. **Output 1**: Scatter plot of raw data
2. **Output 2**: Fit linear regression model → Creates `lm_fit` ✓
3. **Output 3**: Identify outliers and visualize with regression line → Uses `lm_fit` ✓
4. **Output 4**: Refit model without outliers → Uses `lm_fit` and creates `lm_fit_clean` ✓
5. **Output 5**: Side-by-side comparison plots with both models
6. **Output 6**: Publication-ready regression table with gtsummary

## What Learners Will See

### Visual Demonstration
- **Plot 1 (Output 3)**: Original data with regression line, outliers highlighted in red
  - Shows the impact of extreme values on the fitted line
  - IQR method identifies which points are considered outliers
  
- **Output 4 Console**: Side-by-side model summaries
  - Original model coefficients and R²
  - Cleaned model coefficients and R²
  - Direct comparison of impact

- **Plot 2 (Output 5)**: Side-by-side plots
  - Left: WITH OUTLIERS (blue regression line, slope/R² displayed)
  - Right: WITHOUT OUTLIERS (dark red regression line, slope/R² displayed)
  - Visual proof of how outliers distort the relationship

## Key Teaching Points
- Outliers can substantially change regression slopes and intercepts
- R² improves when outliers are removed (cleaner relationship emerges)
- Clinical judgment trumps statistical convenience in outlier decisions
- Always report: what was removed, why, and model comparisons
- Transparency in data analysis builds credibility
