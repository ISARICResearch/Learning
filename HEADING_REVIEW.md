# Heading Structure Review - Linear and Logistic Regression

## Issues Fixed

### 1. **Section Hierarchy**
- **Before**: Document started with `## Linear and Logistic Regression` (mixing two topics)
- **After**: Split into clear sections:
  - `## Linear Regression` (covers Outputs 1-6)
  - `### Logistic Regression` (clear subsection under a new level)

### 2. **Heading Inconsistency**
- **Before**: `### Logistic regression section` (vague, inconsistent capitalization)
- **After**: `### Logistic Regression` (parallel structure, proper capitalization)

### 3. **Bonus Sections**
- **Before**: 
  - `### Bonus: Publication-ready table for logistic regression` (lowercase)
  - `## Bonus 2 - Interpreation with 'report' package` (inconsistent level, typo in "Interpretation")
- **After**:
  - `### Bonus: Publication-Ready Summary Table for Logistic Regression` (consistent capitalization, level)
  - `## Bonus: Alternative Interpretation with the 'report' Package` (clear, typo fixed)

### 4. **Removed Inline Pseudo-Headers**
- **Before**: Code blocks contained lines like:
  - `# ---- Output 4: Logistic regression model ----`
  - `# ---- Output 5: Logistic regression summary ----`
  - `# ---- Output 6: Odds ratios with 95% CIs ----`
- **After**: Replaced with brief, natural comments describing what the code does

## Resulting Structure

```
## Linear Regression
  ### Load packages and dataset
  ### Output 1: Scatter plot
  ### Output 2: Fit linear regression model
  ### Output 3: Visualize regression line and identify outliers
  ### Output 4: Refit model after removing outliers
  ### Output 5: Visualize both models for comparison
  ### Output 6: Publication-ready regression table with gtsummary
  ### Logistic Regression
    ### Bonus: Publication-Ready Summary Table for Logistic Regression

## Bonus: Alternative Interpretation with the `report` Package
```

## Benefits
✓ Clear visual hierarchy in table of contents
✓ Consistent heading capitalization (title case)
✓ Logical nesting: logistic regression as subsection of main section
✓ Proper H2/H3 hierarchy throughout
✓ Code comments now support, not replace, structure
