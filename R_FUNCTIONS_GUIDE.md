# R Functions: A Comprehensive Guide

## Overview

A **function** is a reusable block of code that performs a specific task. Instead of writing the same code repeatedly, you define it once and call it many times with different inputs.

### Why Use Functions?

- **Reduce repetition** — Write once, use many times
- **Improve readability** — Named functions explain intent  
- **Enable testing** — Easier to verify correctness
- **Facilitate maintenance** — Update code in one place
- **Build abstractions** — Hide complexity behind simple interfaces

---

## Anatomy of a Function

```r
my_function <- function(argument1, argument2) {
  # Function body: code that does the work
  result <- argument1 + argument2
  
  # Return statement: specify what the function outputs
  return(result)
}

# Call the function
my_function(5, 3)  # Output: 8
```

### Components Explained

| Component | Purpose | Example |
|-----------|---------|---------|
| **Name** | What you call it | `my_function` |
| **Arguments** | Inputs to the function | `argument1, argument2` |
| **Body** | Code between `{` and `}` | Does the actual work |
| **Return value** | Output of the function | Last line or `return()` statement |

**Key point**: The last line of a function is automatically returned (even without explicit `return()` statement):

```r
# These are equivalent:
add_explicit <- function(a, b) {
  result <- a + b
  return(result)
}

add_implicit <- function(a, b) {
  a + b  # Automatically returned
}

add_explicit(5, 3)  # 8
add_implicit(5, 3)  # 8
```

---

## Basic Examples

### Example 1: Calculate Body Mass Index (BMI)

```r
calculate_bmi <- function(weight_kg, height_m) {
  # BMI = weight / height^2
  bmi <- weight_kg / (height_m^2)
  return(bmi)
}

# Use the function
calculate_bmi(70, 1.75)   # 22.86
calculate_bmi(65, 1.68)   # 23.03
```

### Example 2: Convert Temperature

```r
celsius_to_fahrenheit <- function(celsius) {
  fahrenheit <- (celsius * 9/5) + 32
  fahrenheit
}

celsius_to_fahrenheit(0)    # 32
celsius_to_fahrenheit(100)  # 212
celsius_to_fahrenheit(37)   # 98.6
```

### Example 3: Calculate Medication Dose

```r
calculate_dose <- function(weight_kg, dose_per_kg) {
  # Calculate total dose based on patient weight
  total_dose <- weight_kg * dose_per_kg
  return(total_dose)
}

calculate_dose(70, 10)   # 700 mg
calculate_dose(50, 10)   # 500 mg
```

---

## Function Arguments

### Default Arguments

Set default values so arguments are optional:

```r
greet <- function(name, greeting = "Hello") {
  paste(greeting, name)
}

# Call with all arguments
greet("Alice", "Hi")           # "Hi Alice"

# Call with default greeting
greet("Bob")                   # "Hello Bob"

# Override the default
greet("Carol", "Hey")          # "Hey Carol"
```

### Named Arguments

When calling functions, you can use argument names for clarity:

```r
calculate_bmi <- function(weight_kg, height_m) {
  weight_kg / (height_m^2)
}

# Positional (order matters)
calculate_bmi(70, 1.75)

# Named (order doesn't matter)
calculate_bmi(height_m = 1.75, weight_kg = 70)

# Mix both
calculate_bmi(70, height_m = 1.75)
```

**Best practice**: Use named arguments for clarity, especially in function calls with many arguments.

---

## Calling Functions: Type Expectations and Parameter Requirements

### Understanding Type Requirements

Functions expect arguments to have specific **types** (data types). Supplying the wrong type leads to errors or incorrect results.

**Common data types in R**:
- **numeric** — Numbers: `70`, `1.75`, `-5.2`
- **integer** — Whole numbers: `5L`, `10L`, `0L`
- **character** — Text strings: `"Alice"`, `"Normal"`, `"High"`
- **logical** — Boolean: `TRUE`, `FALSE`
- **vector** — Multiple values: `c(1, 2, 3)`
- **list** — Collection of mixed types
- **data.frame** — Table with rows and columns

### Type Mismatch: Common Errors

#### Example 1: Numeric Expected, String Supplied

```r
calculate_bmi <- function(weight_kg, height_m) {
  weight_kg / (height_m^2)
}

# ✓ CORRECT: Numeric arguments
calculate_bmi(70, 1.75)        # 22.86

# ❌ WRONG: String supplied instead of number
calculate_bmi("70", 1.75)      
# Error: non-numeric argument to binary operator

# ❌ WRONG: Both arguments as strings
calculate_bmi("70", "1.75")    
# Error: non-numeric argument to binary operator
```

**Why it fails**: The function tries to divide `"70"` (text) by `1.75^2` (number), but you can't do arithmetic with text.

---

#### Example 2: Vector Expected, Single Value Supplied

```r
calculate_average <- function(values) {
  sum(values) / length(values)
}

# ✓ CORRECT: Vector of numbers
calculate_average(c(120, 125, 118, 122))   # 121.25

# ⚠ UNEXPECTED: Single value (works but may not be intended)
calculate_average(120)                      # 120
# Calculates average of a single value (always equals itself)

# ❌ WRONG: String value
calculate_average("120")
# Error in sum(values) : invalid 'type' (character) of argument
```

---

#### Example 3: Data Frame Expected, Vector Supplied

```r
get_patient_age <- function(df) {
  # Expects df to be a data frame with an 'age' column
  mean(df$age)
}

# ✓ CORRECT: Data frame with 'age' column
patients <- data.frame(
  name = c("Alice", "Bob", "Carol"),
  age = c(45, 52, 38)
)
get_patient_age(patients)      # 45

# ❌ WRONG: Vector instead of data frame
ages <- c(45, 52, 38)
get_patient_age(ages)
# Error: $ operator is invalid for atomic vectors
```

---

### Why Type Matters: Silent Wrong Results

Sometimes R doesn't error—it silently produces wrong results:

```r
calculate_dose <- function(weight_kg, dose_per_kg) {
  weight_kg * dose_per_kg
}

# ✓ CORRECT: Numeric values
calculate_dose(70, 10)         # 700 mg

# ⚠ SILENT ERROR: String that looks like a number
calculate_dose("70", 10)
# ERROR: non-numeric argument to binary operator

# ⚠ MORE SILENT ERROR: Unexpected type coercion
weight_vector <- c(70, 80, 90)  # Vector of 3 weights
calculate_dose(weight_vector, 10)
# [1] 700 800 900
# Returns a vector, not a single dose!
# Your function expected a single weight, got multiple
# Results are wrong because function didn't validate input
```

**The danger**: If you don't check types, calculations proceed but produce unexpected outputs.

---

### Type Checking: Validation

Always validate input types in clinical functions:

```r
calculate_dose <- function(weight_kg, dose_per_kg) {
  # Validate input types
  if (!is.numeric(weight_kg)) {
    stop("weight_kg must be numeric, got ", class(weight_kg))
  }
  if (!is.numeric(dose_per_kg)) {
    stop("dose_per_kg must be numeric, got ", class(dose_per_kg))
  }
  
  # Check for single value (not vector)
  if (length(weight_kg) != 1) {
    stop("weight_kg must be a single value, got ", length(weight_kg), " values")
  }
  
  # Calculate
  total_dose <- weight_kg * dose_per_kg
  return(total_dose)
}

# ✓ CORRECT
calculate_dose(70, 10)         # 700

# ❌ NOW CATCHES ERROR
calculate_dose("70", 10)
# Error: weight_kg must be numeric, got character

# ❌ NOW CATCHES ERROR
calculate_dose(c(70, 80), 10)
# Error: weight_kg must be a single value, got 2 values
```

---

### Calling Functions: Step-by-Step

#### Step 1: Know What the Function Expects

Read the function definition to understand argument types:

```r
# Function definition tells you what to expect
classify_result <- function(value, test_name = "generic") {
  # 'value' should be numeric (used in comparisons)
  # 'test_name' should be character (checked with ==)
  
  if (test_name == "glucose") {
    if (value < 100) {
      return("Normal")
    }
  }
}

# Arguments needed:
# - value: a single numeric value
# - test_name: a single character string (optional, defaults to "generic")
```

#### Step 2: Supply Arguments with Correct Types

```r
# ✓ CORRECT
classify_result(115, "glucose")        # Numeric + character

# ✓ CORRECT (using default)
classify_result(115)                   # Uses default test_name

# ❌ WRONG
classify_result("115", "glucose")      # String instead of numeric

# ❌ WRONG
classify_result(115, 1)                # Numeric instead of character
```

#### Step 3: Verify Results Make Sense

```r
# After calling a function, always sanity-check the result
result <- calculate_bmi(70, 1.75)
# Is 22.86 reasonable for weight 70 kg, height 1.75 m?
# Yes, this is a normal BMI.

result <- calculate_bmi(70, 0.175)  # Typo: 0.175 instead of 1.75
# Result: 2286 (unreasonably high BMI)
# The function accepted the input but produced wrong result
```

---

### Common Type Issues and Solutions

| Issue | Example | Solution |
|-------|---------|----------|
| **String vs. Numeric** | `calculate_dose("70", 10)` | Convert: `as.numeric("70")` |
| **Vector vs. Single** | `calculate_dose(c(70, 80), 10)` | Extract single: `weights[1]` |
| **Factor vs. Character** | Categorical data with levels | Convert: `as.character(factor_var)` |
| **Integer vs. Numeric** | `c(1L, 2L, 3L)` | Usually not a problem; coercion is automatic |
| **List vs. Data Frame** | Passing `list()` to function expecting `data.frame()` | Convert: `as.data.frame(my_list)` |
| **Missing Values (NA)** | Function doesn't handle `NA` | Add `na.rm = TRUE` or check `is.na()` |

#### Converting Types

```r
# String to numeric
string_weight <- "70"
numeric_weight <- as.numeric(string_weight)
calculate_dose(numeric_weight, 10)     # Works

# Numeric to character
numeric_code <- 123
char_code <- as.character(numeric_code)
paste("Patient ID:", char_code)         # Works

# Vector to single value
weights <- c(70, 80, 90)
first_weight <- weights[1]              # Extract first element
calculate_dose(first_weight, 10)        # Works
```

---

### Parameter Expectations: What Happens When Not Met

When function parameters don't match expectations, results can be:

1. **Error** — Function stops and tells you what's wrong
2. **Silent failure** — Function runs but produces wrong/unexpected results
3. **Unintended behavior** — Function works on something you didn't expect

#### Case 1: Explicit Error (Best)

```r
summarize_values <- function(values) {
  if (!is.numeric(values)) {
    stop("values must be numeric")  # Clear error message
  }
  mean(values)
}

summarize_values("120")
# Error in summarize_values("values must be numeric"
```

#### Case 2: Silent Wrong Results (Dangerous)

```r
# Function WITHOUT validation
bad_summarize <- function(values) {
  mean(values)  # No type checking
}

bad_summarize(c("120", "125", "118"))
# Error: argument is not numeric or logical: returning NA
# [1] NA
# Result is NA (missing), silently hiding the problem

# Another silent failure:
age_data <- c("45", "52", "38")  # Ages as strings, not numbers
bad_summarize(age_data)
# [1] NA
# You might not notice the error until much later
```

#### Case 3: Unexpected Behavior

```r
calculate_annual_dose <- function(daily_dose) {
  # Expects daily_dose to be a single numeric value
  daily_dose * 365
}

# ✓ CORRECT
calculate_annual_dose(10)              # 3650 mg

# ❌ UNEXPECTED but no error
calculate_annual_dose(c(10, 20, 30))   # [1] 3650 7300 10950
# Returns 3 values instead of 1!
# Vectorized calculation (applied to each element)
# Function "works" but gives unexpected output

# ❌ UNEXPECTED
calculate_annual_dose("10")            
# ERROR: non-numeric argument to binary operator
```

---

### Best Practices for Calling Functions

1. **Check function documentation** before calling
   ```r
   ?calculate_bmi  # View function help
   help(mean)      # Detailed documentation
   ```

2. **Verify argument types** match expectations
   ```r
   class(my_weight)  # Check type before calling
   typeof(my_age)    # Alternative check
   ```

3. **Use explicit conversion** when needed
   ```r
   # Instead of hoping type coercion works:
   my_value <- "123"
   result <- calculate_dose(as.numeric(my_value), 10)
   ```

4. **Test with known values** first
   ```r
   # Before using with real data, test with simple values:
   result <- calculate_bmi(70, 1.75)  # Should be ~22.86
   # If correct, then use with real data
   ```

5. **Add defensive checks** in your own functions
   ```r
   my_function <- function(data, threshold) {
     # Validate ALL inputs
     stopifnot(is.numeric(threshold))
     stopifnot(threshold > 0)
     stopifnot(is.data.frame(data))
     # Now proceed safely
   }
   ```

---

## Multiple Return Values

Return multiple values using a **list**:

```r
patient_summary <- function(name, age, bp) {
  category <- if (age >= 65) "Senior" else "Adult"
  bp_status <- if (bp >= 140) "High" else "Normal"
  
  result <- list(
    name = name,
    category = category,
    bp_status = bp_status
  )
  return(result)
}

# Call the function
summary <- patient_summary("Alice", 72, 145)

# Access components
summary$category    # "Senior"
summary$bp_status   # "High"
summary[1]          # List with just the name
```

### Returning Data Frames

```r
get_patient_stats <- function(patients_df) {
  # Calculate statistics for each patient
  stats <- data.frame(
    name = patients_df$name,
    age = patients_df$age,
    bmi = patients_df$weight / (patients_df$height^2),
    age_group = ifelse(patients_df$age >= 65, "Senior", "Adult")
  )
  return(stats)
}
```

### Pattern 3: Conditional Processing

Different outputs based on input conditions:

```r
classify_result <- function(value, test_name = "generic") {
  # Different reference ranges for different tests
  if (test_name == "glucose") {
    if (value < 100) {
      return("Normal")
    }
    if (value < 126) {
      return("Impaired Fasting Glucose")
    }
    return("Diabetic")
  } else if (test_name == "bp_systolic") {
    if (value < 120) {
      return("Normal")
    }
    if (value < 140) {
      return("Elevated")
    }
    return("High")
  } else {
    return("Unknown test")
  }
}

# Use the function
classify_result(115, "glucose")      # "Normal"
classify_result(110, "glucose")      # "Impaired Fasting Glucose"
classify_result(140, "bp_systolic")  # "High"
classify_result(145, "bp_systolic")  # "High"
```
---

## Common Built-in Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `mean()` | Average | `mean(c(10, 20, 30))` → 20 |
| `median()` | Middle value | `median(c(10, 20, 30))` → 20 |
| `sd()` | Standard deviation | `sd(c(10, 20, 30))` |
| `var()` | Variance | `var(c(10, 20, 30))` |
| `sum()` | Sum values | `sum(c(10, 20, 30))` → 60 |
| `prod()` | Product | `prod(c(2, 3, 4))` → 24 |
| `length()` | Count elements | `length(c(10, 20, 30))` → 3 |
| `max()` / `min()` | Maximum/minimum | `max(c(10, 20, 30))` → 30 |
| `range()` | Min and max | `range(c(10, 20, 30))` → 10 30 |
| `quantile()` | Percentiles | `quantile(c(1:100), 0.25)` |
| `paste()` | Combine text | `paste("Age:", 45)` |
| `paste0()` | Combine without space | `paste0("ID_", 123)` |
| `c()` | Combine into vector | `c(1, 2, 3)` |
| `list()` | Create list | `list(name="Alice", age=45)` |
| `data.frame()` | Create table | `data.frame(name, age)` |
| `head()` | First n rows | `head(df, 6)` |
| `tail()` | Last n rows | `tail(df, 6)` |
| `summary()` | Quick summary | `summary(df)` |
| `str()` | Structure/type | `str(df)` |
| `class()` | Data type | `class(df)` |
| `typeof()` | Internal type | `typeof(df)` |
| `nrow()` | Number of rows | `nrow(df)` |
| `ncol()` | Number of columns | `ncol(df)` |
| `dim()` | Dimensions (rows, cols) | `dim(df)` |

---

## Summary

Functions are essential for writing clean, maintainable R code, especially in clinical research where:

- **Reproducibility** — Functions make your analysis repeatable
- **Collaboration** — Others can use and test your functions
- **Validation** — Functions allow for robust input checking
- **Documentation** — Function names and arguments document intent

Start with simple functions and build up to more complex patterns as needed. Remember: a function that does one thing well is better than a function that tries to do everything.

