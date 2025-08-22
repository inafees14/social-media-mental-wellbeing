# Exploring the Impact of Social Media Engagement on the Mental Wellbeing of University Students (DASS‑21 + R)

A research repository accompanying the study **“Exploring the Impact of Social Media Engagement on the Mental Wellbeing of University Students using DASS‑21 and R‑Programming.”**

> Department of Statistics & Operations Research, Aligarh Muslim University (2024)

---

## 🔎 Overview
This repo contains survey instrumentation, cleaned data schema, and R-based analysis workflows used to examine how social media usage relates to **Depression, Anxiety, and Stress** (DASS‑21) among university students. It also includes reproducibility, governance, and contribution guidelines for future collaborators.


## ✨ Key Findings (brief)
- **Sample**: 348 students (≈76% male, ≈24% female).
- **Average total screen time**: ~335 minutes/day; **average social media time**: ~182 minutes/day.
- **Gender differences**: Females reported **higher Stress, Depression, Anxiety** scores; males reported **higher screen time**.
- **Cyberbullying & gender**: No significant association.
- **Interrelations**: Depression, Anxiety, and Stress are **strongly correlated** with each other.

Full statistical details (tests, model summaries, p‑values) are documented in the `analysis/` notebooks and the paper PDF.


## 📦 Repository Structure
```
.
├─ data/
│  ├─ raw/                 # Original survey export(s), untouched (DO NOT COMMIT PII)
│  ├─ interim/             # After light cleaning, no identifiers
│  └─ processed/           # Final analysis-ready CSV(s)
│
├─ docs/
│  ├─ paper/               # Final report PDF and figures
│  └─ instruments/         # DASS‑21 questionnaire, consent form, survey text
│
├─ analysis/
│  ├─ 00_setup.R           # Package installs, paths, helper fns
│  ├─ 01_data_prep.R       # Import, QC, cleaning, recoding
│  ├─ 02_descriptives.R    # Tables & plots for sample profile
│  ├─ 03_inferential.R     # Normality, tests (t/MWU, χ²), correlations
│  ├─ 04_models.R          # Linear models among DASS subscales
│  └─ 99_repro.R           # End‑to‑end reproducibility runner
│
├─ outputs/
│  ├─ figures/             # Exported plots (PNG/PDF/SVG)
│  ├─ tables/              # CSV/HTML tables (descriptives, test summaries)
│  └─ logs/                # Render logs, session info
│
├─ CITATION.cff            # How to cite this work
├─ CODE_OF_CONDUCT.md      # Community standards
├─ CONTRIBUTING.md         # How to contribute
├─ LICENSE                 # Project license
└─ README.md               # You are here
```


## 🧪 Methods Summary
- **Instrument**: DASS‑21 (Depression, Anxiety, Stress; 7 items each).
- **Scoring**: 0–3 Likert per item; subscale totals multiplied by 2 for severity banding.
- **Variables**: Gender, Level of Study (UG/PG/PhD), Area of Study (5 categories), Total Screen Time (min), Total Social Media Time (min), DASS subscale scores; cyberbullying experience.
- **Data prep**: Missing‑data handling, recoding, and normality checks (Shapiro–Wilk). Box‑Cox used where applicable.
- **Analyses**:
  - Descriptives & visualizations (bar charts, histograms, scatter/heat maps)
  - Group comparisons by gender & other demographics (t‑test / Mann–Whitney U as needed)
  - Associations among categorical variables (χ²)
  - Correlations among continuous variables
  - Linear models among DASS subscales (e.g., ANXIETY ~ DEPRESSION + STRESS)


## 🗂️ Data Dictionary (analysis‑ready `processed/`)
| Field | Type | Description |
|---|---|---|
| `Gender` | factor {Male, Female} | Respondent gender |
| `LOS` | factor {UG, PG, PhD} | Level of study |
| `AOS2` | factor {SciLife, Eng, Medical, CommerceMgmt, ArtsHum} | Area of study |
| `TST` | numeric (minutes) | Total daily screen time |
| `TSTR` | numeric (minutes) | Total daily social media time |
| `STRESS` | numeric | DASS‑21 Stress (post‑scaling) |
| `DEPRESSION` | numeric | DASS‑21 Depression (post‑scaling) |
| `ANXIETY` | numeric | DASS‑21 Anxiety (post‑scaling) |
| `CBull` | factor {No, Yes} | Self‑reported cyberbullying experience |

> ⚠️ **PII**: No direct identifiers are stored.


## 📊 Reproducibility
- Save a session snapshot with `sessionInfo()`; exported to `outputs/logs/session_info.txt`.
- Random operations should set a seed, e.g., `set.seed(2024)`.
- All charts/tables are rendered via scripts so they can be regenerated end‑to‑end.


## 🧭 Governance & Ethics
- **Consent**: Survey participation was voluntary; data analyzed in aggregate.
- **Privacy**: Only de‑identified records are shared. Any raw files containing PII remain private.
- **Risk**: Mental‑health related variables are sensitive; avoid re‑identification attempts. See `docs/instruments/consent.md`.


## 📈 What’s Implemented (scripts)
- Descriptives (counts/percentages, summary stats)
- Normality checks (Shapiro–Wilk), fallback to nonparametrics (Mann–Whitney U)
- χ² tests for categorical associations
- Correlation matrices/heatmaps
- Linear models among DASS subscales (with R², F‑tests, coefficients)

> The repository intentionally separates **raw code** (you’ll provide) from **organized, documented scripts**. Place your raw files in `analysis/_raw/` and we’ll integrate them into the structured pipeline above.


## 🧩 Figures & Tables (examples expected in `outputs/`)
- Gender/LOS/AOS distributions (bar charts)
- Histograms for TST/TSTR
- DASS severity banding tables
- χ² summary tables (e.g., Gender × CBull)
- Model summaries (e.g., ANXIETY ~ DEPRESSION + STRESS)


## 🧑‍🤝‍🧑 Contributing
Please read `CONTRIBUTING.md` for guidelines on issues, branches (feature/bugfix/docs), commits, and PR reviews. All contributors must follow the `CODE_OF_CONDUCT.md`.


## 📚 Citation
If you use this repository, please cite:

```yaml
# CITATION.cff (excerpt)
cff-version: 1.2.0
title: Exploring the Impact of Social Media Engagement on Mental Wellbeing (DASS‑21 + R)
authors:
  - family-names: Iqbal
    given-names: M Nafees
  - family-names: Khan
    given-names: Anzar
version: 1.0.0
date-released: 2024-06-01
repository-code: https://github.com/inafees14/social-media-mental-wellbeing
```


## 🙏 Acknowledgements
- Supervisors and Department of Statistics & Operations Research, AMU
- All student respondents who completed the survey


## 📬 Contact
For questions and collaboration, please open an issue or reach out via GitHub.

---

### Changelog
- `v1.0.0` – Initial public release of README and repository layout.
