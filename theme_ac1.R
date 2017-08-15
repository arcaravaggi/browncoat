# Custom ggplot theme for publication-quality figures
#
# base_family = font family (default = serif)
# base_size_a = font size for axis text (default = 12)
# base_size_t = font size for axis title text (default = 12)
#
# Example:
#
# a <- runif(1000, 0, 100)
# b <- runif(1000, 0, 100)
# dat <- data.frame(a, b)
#
# ggplot(dat, aes(x = a, y = b)) +
#   geom_point() + 
#   theme_new()

theme_ac1 <- function(base_family = "serif", base_size_a = 12, base_size_t = 12){
  theme_bw(base_family = base_family) %+replace%
    theme(
      plot.background = element_blank(),
      panel.grid = element_blank(),   
      axis.text = element_text(size = base_size_a),
      axis.title = element_text(size=base_size_t,face="bold"),
      legend.key=element_rect(colour=NA, fill =NA),
      panel.border = element_rect(fill = NA, colour = "black", size=0),
      panel.background = element_rect(fill = "white", colour = "black"), 
      strip.background = element_rect(fill = NA)
    )
}