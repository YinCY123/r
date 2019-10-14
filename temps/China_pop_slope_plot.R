
library(readr)
xx <- read_xlsx(path = "xx.xlsx")
xx <- as_tibble(xx)

colnames(xx) <- c("area", "pop", "2000", "2010")
xx <- xx %>% 
    gather(key = "year", value = "ratio", -area, -pop)

xx <- type_convert(xx, col_types = cols(year = col_date(format = "%Y"))) %>% 
    mutate(year = lubridate::year(year))

an_2000 <- xx %>% 
    filter(year == "2000")

an_2010 <- xx %>% 
    filter(year == "2010")

xx %>% 
    ggplot(aes(year, ratio)) +
    geom_point(size = 0) +
    geom_line(aes(group = area, color = area), size = 1.2,show.legend = F) +
    labs(xlab = "", ylab = "")+
    scale_x_continuous(name = NULL, breaks = c(2000, 2010), 
                       labels = NULL, limits = c(1999, 2012)) +
    scale_y_continuous(name = NULL, labels = NULL) +
    theme(axis.ticks.length.x = unit(x = 0, units = "cm"),
          axis.ticks.length.y = unit(x = 0, units = "cm"),
          plot.margin = unit(x = c(0, 1, 0, 1), units = "cm")) +
    geom_text(aes(year-0.1, ratio, label = area), data = an_2000, size = 3,
              hjust = "right") +
    geom_text(aes(year + 0.1, ratio, label = area), data = an_2010, size = 3, 
              hjust = "left") +
    geom_text(aes(x = 2002.5, y = range(xx$ratio)[2]*0.999, 
                  label = "Population Ration Change in China between 2000 and 2010"),
              size = 5)
    
write.table(x =xx, file = "China_pop_2000_2010.txt", sep = "\t")
