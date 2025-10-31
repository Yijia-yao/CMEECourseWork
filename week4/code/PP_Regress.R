# --------------------------
# Load required packages
# --------------------------
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
})

# --------------------------
# Load and clean data
# --------------------------
data_path <- "../data/EcolArchives-E089-51-D1.csv"

pp_data <- read_csv(data_path, show_col_types = FALSE)

pp_data_clean <- pp_data %>%
  filter(!is.na(Predator.mass), !is.na(Prey.mass),
         Predator.mass > 0, Prey.mass > 0) %>%
  mutate(
    Predator.lifestage = trimws(Predator.lifestage),
    Predator.lifestage = recode(Predator.lifestage,
                                "larva / juvenile" = "larva/juvenile",
                                "postlarva/juvenile" = "postlarva/juvenile"),
    Type.of.feeding.interaction = factor(Type.of.feeding.interaction)
  )

# --------------------------
# Define regression helper
# --------------------------
get_regression_results <- function(data) {
  if (nrow(data) < 2) return(NULL)
  model <- lm(log10(Predator.mass) ~ log10(Prey.mass), data = data)
  sm <- summary(model)
  data.frame(
    slope = coef(model)[2],
    intercept = coef(model)[1],
    R2 = sm$r.squared,
    p_value = anova(model)$`Pr(>F)`[1],
    n = nrow(data)
  )
}

# --------------------------
# Run regressions by feeding type × lifestage
# --------------------------
regression_results <- pp_data_clean %>%
  group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
  filter(n() >= 3) %>%
  group_modify(~ get_regression_results(.x)) %>%
  ungroup() %>%
  arrange(Type.of.feeding.interaction, Predator.lifestage)

# Save results
write_csv(regression_results, "../results/PP_Regress_Results.csv")

# --------------------------
# Create plot
# --------------------------
pp_plot <- ggplot(pp_data_clean,
                  aes(x = Prey.mass, y = Predator.mass,
                      colour = Predator.lifestage)) +
  geom_point(alpha = 0.6, size = 1.8, shape = 3) +
  geom_smooth(method = "lm", se = TRUE,
              fill = "grey70", alpha = 0.3, linewidth = 0.7) +
  scale_x_log10(name = "Prey Mass in grams",
                breaks = 10^seq(-7, 2, by = 2),
                labels = scales::scientific_format(digits = 2)) +
  scale_y_log10(name = "Predator mass in grams",
                breaks = 10^seq(-6, 6, by = 2),
                labels = scales::scientific_format(digits = 2)) +
  facet_wrap(~ Type.of.feeding.interaction, ncol = 1, scales = "free_y") +
  scale_colour_manual(
    name = "Predator.lifestage",
    values = c(
      "adult" = "#e41a1c",
      "juvenile" = "#ff7f00",
      "larva" = "#4daf4a",
      "larva/juvenile" = "#377eb8",
      "postlarva" = "#984ea3",
      "postlarva/juvenile" = "#a65628"
    )
  ) +
  theme_bw(base_size = 10) +
  theme(
    strip.background = element_rect(fill = "white"),
    strip.text = element_text(face = "bold", size = 9),
    legend.position = "bottom",
    legend.title = element_text(size = 9),
    legend.text = element_text(size = 8),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(size = 0.3, linetype = "dotted"),
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 10)
  )

# --------------------------
# Save plot in multiple formats
# --------------------------
dir.create("../results", showWarnings = FALSE)

ggsave("../results/PP_Regress_Improved.pdf", pp_plot, width = 7, height = 9)
ggsave("../results/PP_Regress_Improved.png", pp_plot, width = 7, height = 9, dpi = 300)

# --------------------------
# Summary message
# --------------------------
cat("redator-prey regression analysis complete!\n")
cat("Results saved to: ../results/PP_Regress_Results.csv\n")
cat("Plot saved to: ../results/PP_Regress_Improved.pdf and .png\n")
cat("Total models fitted:", nrow(regression_results), "\n")




















