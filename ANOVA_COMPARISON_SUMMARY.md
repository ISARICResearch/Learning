# Statistical Model Comparison with ANOVA - New Output 4.5

## What Was Added

A new section (Output 4.5) that performs formal statistical comparison of the two linear regression models:
- **Model 1**: Linear regression with all data (including outliers)
- **Model 2**: Linear regression after outlier removal

## Code Components

### 1. ANOVA F-Test
```r
anova(lm_fit, lm_fit_clean)
```
- Compares residual sum of squares between models
- Produces F-statistic and p-value
- Tests whether outlier removal significantly improves fit

### 2. Residual Standard Error Comparison
- **Original model σ**: Residual standard error with outliers
- **Cleaned model σ**: Residual standard error without outliers
- **Difference**: Quantifies improvement in prediction accuracy

### 3. Residual Sum of Squares (RSS)
- **Original model RSS**: Total squared errors with outliers
- **Cleaned model RSS**: Total squared errors without outliers
- **Difference (RSS₁ - RSS₂)**: Error reduction from outlier removal

## What Learners Will See

### ANOVA Table Output
```
Analysis of Variance Table

Model 1: outco_lengthofstay ~ demog_age (with outliers)
Model 2: outco_lengthofstay ~ demog_age (without outliers)

  Res.Df      RSS Df Sum of Sq      F   Pr(>F)
1   1266 ......... 
2   1255 ......... ## sum of sq from outliers
```

### Interpretation Summary
- Residual standard error (σ) reduced from ~X to ~Y
- RSS reduced by Z units
- F-test result shows statistical significance (if p < 0.05)

## Teaching Points

1. **Quantitative Impact**: Shows exactly how much outliers affect model fit
2. **Statistical Rigor**: ANOVA provides formal test, not just visual inspection
3. **Residual Diagnostics**: RSS and σ are key measures of model quality
4. **Clinical vs. Statistical Significance**: Reminds learners that even statistically significant improvements must be clinically meaningful

## Callout Highlights

**Callout 1 (tip)**: Explains what ANOVA is testing and how to interpret the p-value

**Callout 2 (important)**: Emphasizes the four key metrics:
- Lower RSS = better fit
- Lower residual std. error = smaller prediction errors
- Higher R² = more variance explained
- Clinical vs. statistical significance distinction

## Integrated Learning Path

1. **Output 3**: Visual evidence of outliers and their impact
2. **Output 4**: Model summaries showing changed coefficients/R²
3. **Output 4.5**: Statistical proof that improvement is significant
4. **Output 5**: Side-by-side visual comparison
5. **Output 6**: Publication-ready table format

This creates a complete story: identify → quantify → test → visualize → report
