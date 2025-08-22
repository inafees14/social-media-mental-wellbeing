# =============================================================
# 00_setup.R
# Project: Social Media & Mental Wellbeing (DASS-21 + R)
# =============================================================

# ---- Packages ----
packages <- c(
  "tidyverse", "psych", "reshape2",
  "car", "rstatix", "corrplot"
)

install_if_missing <- function(pkg){
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

lapply(packages, install_if_missing)

invisible(lapply(packages, library, character.only = TRUE))

# ---- Paths ----
raw_path       <- "data/raw/"
processed_path <- "data/processed/"
output_figs    <- "outputs/figures/"
output_tabs    <- "outputs/tables/"
output_logs    <- "outputs/logs/"

# ---- Helpers ----
set.seed(2024)


# =============================================================
# 01_data_prep.R
# =============================================================

source("analysis/00_setup.R")

# Import processed dataset (CSV)
data <- read.csv(file.path(processed_path, "study_processed.csv"))

# Quick structure check
str(data)

# Recode factors
cols_factor <- c("Gender", "LOS", "AOS2", "CBull")
data[cols_factor] <- lapply(data[cols_factor], factor)

# Inspect missing
sum(is.na(data))

# Save cleaned interim
write.csv(data, file.path(processed_path, "study_clean.csv"), row.names = FALSE)


# =============================================================
# 02_descriptives.R
# =============================================================

source("analysis/00_setup.R")
data <- read.csv(file.path(processed_path, "study_clean.csv"))

# Summary statistics
descriptives <- data %>% select(TST, TSTR, STRESS, DEPRESSION, ANXIETY) %>% psych::describe()
write.csv(descriptives, file.path(output_tabs, "descriptives.csv"))

# Gender distribution (barplot)
png(file.path(output_figs, "gender_dist.png"))
barplot(table(data$Gender), col="skyblue", main="Gender Distribution", ylab="Count")
dev.off()

# Histogram for total screen time
png(file.path(output_figs, "tst_hist.png"))
hist(data$TST, breaks=20, col="lightgrey", main="Total Screen Time", xlab="Minutes")
dev.off()

# Correlation heatmap
cor_mat <- cor(data %>% select(STRESS, DEPRESSION, ANXIETY), use="pairwise")
png(file.path(output_figs, "cor_heatmap.png"))
corrplot(cor_mat, method="color", addCoef.col="black")
dev.off()


# =============================================================
# 03_inferential.R
# =============================================================

source("analysis/00_setup.R")
data <- read.csv(file.path(processed_path, "study_clean.csv"))

# Normality tests
shapiro_results <- data %>% select(STRESS, DEPRESSION, ANXIETY) %>%
  gather(key="scale", value="score") %>%
  group_by(scale) %>%
  summarise(shapiro_p = shapiro.test(score)$p.value)

write.csv(shapiro_results, file.path(output_tabs, "shapiro_results.csv"))

# Gender comparison: Stress
ttest_stress <- t.test(STRESS ~ Gender, data = data)
cat("Stress Gender t-test\n", capture.output(ttest_stress),
    file = file.path(output_tabs, "ttest_stress.txt"))

# Mann-Whitney for non-normal
test_anxiety <- wilcox.test(ANXIETY ~ Gender, data=data)
cat("Anxiety Gender MWU\n", capture.output(test_anxiety),
    file=file.path(output_tabs, "mwu_anxiety.txt"))

# Chi-square: Gender × Cyberbullying
chisq_cbull <- chisq.test(table(data$Gender, data$CBull))
cat("Chi-square Gender×Cyberbullying\n", capture.output(chisq_cbull),
    file=file.path(output_tabs, "chisq_cbull.txt"))


# =============================================================
# 04_models.R
# =============================================================

source("analysis/00_setup.R")
data <- read.csv(file.path(processed_path, "study_clean.csv"))

# Linear regression Anxiety ~ Depression + Stress
model1 <- lm(ANXIETY ~ DEPRESSION + STRESS, data=data)

sink(file.path(output_tabs, "lm_anxiety.txt"))
summary(model1)
sink()

# Linear regression Depression ~ Stress
model2 <- lm(DEPRESSION ~ STRESS, data=data)

sink(file.path(output_tabs, "lm_depression.txt"))
summary(model2)
sink()

# Save diagnostic plots
png(file.path(output_figs, "lm_anxiety_diag.png"))
par(mfrow=c(2,2))
plot(model1)
dev.off()


# =============================================================
# 99_repro.R
# =============================================================

source("analysis/01_data_prep.R")
source("analysis/02_descriptives.R")
source("analysis/03_inferential.R")
source("analysis/04_models.R")

# Save session info
sink(file.path(output_logs, "session_info.txt"))
sessionInfo()
sink()
