# Unified renderer: Render both Quarto (.qmd) and Markdown (.md) files to PDF
# This script processes all .qmd files from the course directory and .md files from root

cat("========================================\n")
cat("Rendering all Quarto and Markdown files to PDF\n")
cat("========================================\n\n")

# Find all .qmd files in the course directory
qmd_files <- dir(
  path = "Introduction-to-Statistics-for-Clinical-Research-main/",
  pattern = "\\.qmd$",
  full.names = FALSE
)

# Find all .md files in the root directory (excluding README.md which is a guide)
md_files <- dir(
  path = ".",
  pattern = "\\.md$",
  full.names = FALSE
)
md_files <- md_files[md_files != "README.md"]

# Combine and organize files
all_files <- c(
  paste0("Introduction-to-Statistics-for-Clinical-Research-main/", qmd_files),
  md_files
)

cat("Found", length(qmd_files), "Quarto files (.qmd):\n")
print(qmd_files)
cat("\nFound", length(md_files), "Markdown files (.md):\n")
print(md_files)
cat("\nTotal files to render to PDF:", length(all_files), "\n\n")

# Render each file to PDF
purrr::walk(all_files, \(x) {
  cat("Rendering:", x, "to PDF")

  tryCatch(
    {
      quarto::quarto_render(
        input = x,
        output_format = "pdf"
      )
      cat(" ✓\n")
    },
    error = function(e) {
      cat(" ✗ Error:", e$message, "\n")
    }
  )
})

cat("\n✓ PDF rendering complete!\n")
cat(
  "  • All PDF files in: Introduction-to-Statistics-for-Clinical-Research-main/\n"
)
cat("                      and root directory (./)\n")
