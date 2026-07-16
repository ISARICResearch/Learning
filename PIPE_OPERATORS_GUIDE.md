# R Pipe Operators: `|>` vs `%>%`

## Overview

Pipes are operators that pass the output of one function as input to the next, creating readable "pipelines" that flow left-to-right instead of nested function calls. R has two main pipe operators:

- **`|>`** — Native R pipe (base R, R 4.1+)
- **`%>%`** — Magrittr pipe (from tidyverse ecosystem)

---

## Quick Comparison

| Feature | `|>` (Base) | `%>%` (Magrittr) |
|---------|-----------|-----------------|
| **Package Required** | None (base R) | `magrittr` |
| **Available Since** | R 4.1.0 (2021) | 2014 (via magrittr) |
| **Performance** | Faster (native) | Slightly slower |
| **Placeholder** | `_` (underscore) | `.` (dot) |
| **Learning Curve** | Simpler, more consistent | Slightly more flexible |
| **Ecosystem** | Growing (modern tidyverse) | Established (widely used) |
| **Error Messages** | Better (native) | More verbose sometimes |

---

## Syntax Basics

### Base Pipe `|>`

```r
x |> f(arg1, arg2)
# Equivalent to:
f(x, arg1, arg2)

# With placeholder for non-first argument:
x |> f(arg1, _, arg2)
# Equivalent to:
f(arg1, x, arg2)
```

### Magrittr Pipe `%>%`

```r
x %>% f(arg1, arg2)
# Equivalent to:
f(x, arg1, arg2)

# With placeholder for non-first argument:
x %>% f(arg1, ., arg2)
# Equivalent to:
f(arg1, x, arg2)
```

---

## Examples

### Example 1: Basic Pipeline

**Problem**: Take a vector, filter it, square it, and find the mean.

**Nested (hard to read)**:
```r
mean(sqrt(abs(c(-5, -3, 0, 2, 5))))
```

**Base Pipe `|>`**:
```r
c(-5, -3, 0, 2, 5) |>
  abs() |>
  sqrt() |>
  mean()
```

**Magrittr Pipe `%>%`**:
```r
c(-5, -3, 0, 2, 5) %>%
  abs() %>%
  sqrt() %>%
  mean()
```

---

### Example 2: Data Frame Manipulation

**Base Pipe `|>`**:
```r
library(dplyr)

df |>
  filter(age > 30) |>
  select(name, age, income) |>
  arrange(desc(income)) |>
  head(10)
```

**Magrittr Pipe `%>%`**:
```r
df %>%
  filter(age > 30) %>%
  select(name, age, income) %>%
  arrange(desc(income)) %>%
  head(10)
```

Both produce identical results. The choice depends on your ecosystem preference.

---

### 3. **Performance**

**Base pipe is faster**:
```r
# Benchmark (simplified):
# Base pipe |>:   ~0.1 ms per operation (native implementation)
# Magrittr %>%:   ~0.15 ms per operation (function call overhead)
```

For most analyses, this difference is negligible. It matters only in tight loops with millions of operations.

---

## When to Use Each

### Use Base Pipe `|>` When:
✓ You want the simplest, most modern syntax  
✓ You're using modern tidyverse (v2.0+)  
✓ You're writing new code and want future compatibility  
✓ You need better error messages  
✓ You prefer base R over external dependencies  
✓ Performance matters (though usually negligible)  

**Recommendation**: Use `|>` for new code; it's the direction R is headed.

### Use Magrittr `%>%` When:
✓ Working with legacy tidyverse code  
✓ Your colleagues use it and expect consistency  
✓ You need the `{.}` braces shorthand  
✓ You're using older packages that assume `%>%`  
✓ You're teaching and your materials use `%>%`  

---

## Best Practices

1. **Choose one and stick with it** in a project
2. **Use base pipe `|>`** for new code
3. **Add comments** for complex pipelines:
   ```r
   patient_data |>
     # Exclude minors and missing outcomes
     filter(age >= 18, !is.na(outcome)) |>
     # Create age categories for stratification
     mutate(age_group = cut(age, breaks = c(0, 30, 50, Inf))) |>
     # Calculate summary statistics
     group_by(age_group) |>
     summarise(mean_outcome = mean(outcome))
   ```

4. **Line breaks for readability**: Put `|>` at end of line (or start of next)
   ```r
   # Preferred:
   x |>
     f() |>
     g()
   
   # Also OK:
   x |> f() |> g()  # Short pipelines only
   ```

5. **Use intermediate variables** for debugging:
   ```r
   step1 <- df |> filter(age > 30)
   step2 <- step1 |> mutate(age_group = cut(age, ...))
   # Easier to inspect intermediate results
   ```

---

## Summary Table

| Scenario | Recommendation |
|----------|-----------------|
| New project, R 4.1+ | Use `\|>` |
| Legacy tidyverse code | Keep `%>%` (or convert) |
| Teaching modern R | Use `\|>` |
| Maximum compatibility | Use `%>%` |
| Publication code | Use `\|>` (future-proof) |
| Complex pipeline | Use `\|>` with comments |
| Performance-critical | Use `\|>` (marginal gain) |

---

## Further Reading

- [R 4.1 Release Notes on Native Pipe](https://www.r-project.org/news/R-4-1-0-released.html)
- [magrittr Documentation](https://magrittr.tidyverse.org/)
- [tidyverse Style Guide](https://style.tidyverse.org/pipes.html)
- [Base Pipe Documentation](https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Pipes)

---

## Conclusion

Both `|>` and `%>%` create readable, maintainable code by replacing deeply nested function calls. 

- **Start with `|>`** if you're new to R or beginning a new project
- **Respect existing code**: use `%>%` if that's what the project uses
- **Understand both**: they're conceptually equivalent, just syntactically different

The key is reading pipelines top-to-bottom and understanding that the left side flows into the right side. Master either one, and switching between them is straightforward.
