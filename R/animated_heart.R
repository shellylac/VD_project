library(here)
library(pander)
library(ggplot2)
library(gganimate)
library(data.table)
library(png)
library(grid)
img <- readPNG(source = here("figs_reports", "VDmessage.png"))
g <- rasterGrob(img, interpolate = TRUE)

gen_heart_y <- function(x, a) {
  # source: https://i.imgur.com/avE8cxJ.gifv
  (x^2)^(1 / 3) + 0.9 * (3.3 - x^2)^(1 / 2) * sin(a * pi * x)
}

heart_dt_list <- lapply(seq(1, 60, by = 0.05), function(a) {
  heart_dt <- data.table(x = seq(-1.8, 1.8, length.out = 500), a = a)
  heart_dt[, y := gen_heart_y(x, a)]
  return(heart_dt)
})

full_heart_dt <- rbindlist(heart_dt_list)

animated_heart <- ggplot(full_heart_dt, aes(x, y)) +
  geom_line(color = "firebrick3") +
  annotation_custom(g, xmin = -Inf, xmax = Inf, ymin = -1, ymax = 2.3) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#d8bfd8", color = NA)) +
  transition_manual(a)

animation <- animate(animated_heart, width = 400, height = 400, renderer = gifski_renderer())

# animation

save_animation(animation, here("images", "heart_animated.gif"))
