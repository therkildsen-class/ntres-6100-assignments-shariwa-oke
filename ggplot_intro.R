library(tidyverse)
mpg
?mpg

cars

View(mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
##This particular scatterplot isn't useful because there are lots of categorical data points which means they are all on top of each other


##This plot has some outliers from the trend line, so we can start changing some of the outlier points by modifying the aesthetics according to their data
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))
##changing color according to variables

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
##changing all the colors of the data points

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
##this is great, but there is repetition in this code

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth()
##so you can move the mapping specifications up to the ggplot line

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth() +
  facet_wrap(~ year)
##the facet_wrap function you can split the data by year

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class)
##you can also split by categoriacl data

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class) +
  theme_get()
##you can also change the themes of the ggplot--this is the colors and design elements  
  
##you can save plots directly from code and this provides information about how you got to that plot
ggsave(filename = "plots/hwy_vs_dipl.png")
?ggsave

##you can also name your plots to keep things organized
plot1 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth()

##and then save your plots with the the plot names
plot1  
ggsave(filename = "plots/prettyplot.png", plot = plot1)

##you also don't need to write filename because ggplot expects that to be in the first spot, so you can just put it in the first spot
ggsave("plots/prettyplot.png", plot = plot1)