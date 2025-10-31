# MyBars.R
# Annotated bar plot using geom_linerange and geom_text

# Load necessary library
library(ggplot2)

# Read data
a <- read.table("../data/Results.txt", header = TRUE)

# Inspect first few rows
head(a)

# Add a column of zeros for ymin
a$ymin <- rep(0, nrow(a))

# Create the base plot
p <- ggplot(a)

# First linerange
p <- p + geom_linerange(aes(x = x, ymin = ymin, ymax = y1),
                        colour = "#E69F00",
                        alpha = 0.5,
                        linewidth = 0.5,
                        show.legend = FALSE)

# Second linerange
p <- p + geom_linerange(aes(x = x, ymin = ymin, ymax = y2),
                        colour = "#56B4E9",
                        alpha = 0.5,
                        linewidth = 0.5,
                        show.legend = FALSE)

# Third linerange
p <- p + geom_linerange(aes(x = x, ymin = ymin, ymax = y3),
                        colour = "#D55E00",
                        alpha = 0.5,
                        linewidth = 0.5,
                        show.legend = FALSE)

# Annotate plot with labels
p <- p + geom_text(aes(x = x, y = -500, label = Label), na.rm = TRUE)

# Set axis labels and theme
p <- p + scale_x_continuous("My x axis", breaks = seq(3, 5, by = 0.05)) +
        scale_y_continuous("My y axis") +
        theme_bw() +
        theme(legend.position = "none")

# Create results directory if it doesn't exist
if(!dir.exists("results")) {
  dir.create("results")
}

# Save the plot as PDF
ggsave(filename = "../results/MyBars.pdf", plot = p, width = 8, height = 5)

# Optional: print the plot to the default device
print(p)
