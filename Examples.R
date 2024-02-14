
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(gapminder)) install.packages("gapminder")
if (!require(ggthemes)) install.packages("ggthemes")


library(ggplot2)
library(ggthemes)
library(gapminder)


#####################################
############# Testing ###############
#####################################
  
  teal <- "#0B4C5B"
  gold <- "#FFB52C"
  teal_gray <- "#85A5AD"
  light_teal <- "#006970"
  cream <- "#F3F6F7"
  dark_gray <- "#394649"
  teal_black <- "#1A272A"
  blue <- "#2D99B5"
  light_blue <- "#BFDEE0"
  light_gold <- "#FEE8BF"
  light_gray <-  "#DFE0E2"
  red <- "#D15553"
  green <- "#00896C"
  
  categorical <- c(light_teal, gold, blue, light_blue, light_gold, teal_gray,
                   dark_gray, light_gray)
  
  sequential1 <- light_teal
  sequential2 <- c(light_blue, light_teal)
  sequential3 <- c(light_gray, light_blue, light_teal)
  sequential4 <- c(light_gray, light_blue, light_teal, dark_gray)
  sequential8 <- c(light_gray, teal_gray, light_blue, blue, light_teal,
                   teal, dark_gray, teal_black)
  sequential <- list(sequential1, sequential2, sequential3, sequential4, sequential8)
  
  polar1 <- light_teal
  polar2 <- c(light_teal, gold)
  polar3 <- c(light_teal, teal_gray, gold)
  polar4 <- c(light_teal, teal_gray, light_gold, gold)
  polar5 <- c(light_teal, teal_gray, light_blue, light_gold, gold)
  polar <- list(polar1, polar2, polar3, polar4, polar5)
  
  stoplight <- c(green, gold, red)
  
  
  
  windowsFonts(SofiaPro = windowsFont("Sofia Pro")) ## This allows the user to embed the Sofia Pro font within pdfs saved in R. Use ggsave(ggplot_object, filename = paste0(figures, "/word embedding bootstrap.pdf"), device = cairo_pdf)
  
  theme_cgd <- theme_classic() +
    theme(text = element_text(family = "Sofia Pro"),
          plot.title = element_text(color = teal),
          plot.subtitle = element_text(color = teal), ## Ideally, these should be in bold
          axis.title = element_text(color = teal), ## Ideally, these should be in bold
          axis.text = element_text(color = teal_black),
          axis.line = element_line(color = teal_black), ## size = 1 is too large here
          axis.ticks = element_blank(),
          axis.title.y = element_blank(),
          legend.title = element_text(color = teal),
          legend.text = element_text(color = teal_black),
          strip.text = ggplot2::element_text(hjust = 0)
    )

  #####################################
  ############# Examples ##############
  #####################################
  
  
  View(gapminder)
  
  gapminder_1952 <- gapminder %>%
    filter(year == 1952) %>%
    slice_sample(n = 5, by = continent) %>%
    mutate(country = fct_reorder(country, desc(lifeExp)))

######## Bar chart  ########

##  Categorical variable
  set.seed(10)
  gapminder_1952 %>%
    ggplot() +
    geom_col(aes(country, lifeExp, fill = continent)) +
    coord_flip() +
    scale_fill_discrete(type = categorical) +
    labs(y = "Life expectancy in 1952",
         fill = "") +
    theme_cgd

## Not great...Light teal and light gold are too pale to see against the 
## white background.

### Color: continuous, binned variable
  set.seed(10)
  gapminder_1952 %>%
    mutate(gdpPercap_q = as_factor(ntile(gdpPercap, 5))) %>%
    ggplot() +
    geom_col(aes(country, lifeExp, fill = gdpPercap_q)) +
    coord_flip() +
    scale_fill_discrete(type = sequential) +
    labs(fill = "Income level (1 = low)") +
    theme_cgd

## Again, the light grey is really too pale.

### Color: continuous, gradient variable
  set.seed(10)
  gapminder_1952 %>%
    mutate(log_gdp = log(gdpPercap)) %>%
    ggplot() +
    geom_col(aes(country, lifeExp, fill = log_gdp)) +
    coord_flip() +
    scale_fill_gradientn(colors = sequential2) +
    labs(y = "Life expectancy in 1952",
         fill = "Log GDP per capita") +
    theme_cgd

### Color: continuous, gradient variable using alpha

  set.seed(10)
  gapminder_1952 %>%
    mutate(log_gdp = log(gdpPercap)) %>%
    ggplot() +
    geom_col(aes(country, lifeExp, alpha = log_gdp), fill = light_teal) +
    coord_flip() +
    scale_fill_gradientn(colors = sequential2) +
    labs(y = "Life expectancy in 1952",
         fill = "Log GDP per capita") +
    theme_cgd


##### Scatter plot  #####

  set.seed(10)
  gapminder %>%
    mutate(log_gdp = log(gdpPercap)) %>%
    ggplot() +
    geom_point(aes(log_gdp, lifeExp, color = continent)) +
    scale_color_discrete(type = categorical) +
    facet_wrap(~ year) +
    labs(subtitle = "Life expectancy",
         x = "Log GDP per capita",
         color = " ") +
    theme_cgd

##### Line graph #####

  set.seed(10)
  gapminder %>%
    group_by(continent, year) %>%
    summarise(lifeExp_cont = mean(lifeExp)) %>%
    ggplot() +
    geom_line(aes(year, lifeExp_cont, color = continent), linewidth = 2) +
    geom_vline(xintercept = 1980, linetype = "longdash", color = teal_gray) +
    labs(subtitle = "Life expectancy",
         color = "") +
    scale_color_discrete(type = categorical) +
    theme_cgd

## Faint colors are a problem. Line width also too low.
