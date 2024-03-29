library(tidyverse)
library(scales)
library(glue)

t_data = read_csv('data/GLB.Ts+dSST.csv', skip = 1, na = '***') %>% 
  select(year = Year, t_diff = `J-D`) %>% 
  drop_na()



t_data %>% 
  ggplot(aes(x=year, y=1, fill=t_diff)) +
  geom_tile(show.legend = F) +
  scale_fill_stepsn(colors=c('#1945A6', 'white', '#D10225'),
                    values = rescale(c(min(t_data$t_diff),0,max(t_data$t_diff))),
                    n.breaks=12) +
  coord_cartesian(expand=F) +
  scale_x_continuous(breaks = seq(1890, 2020, 30)) +
  theme_void() +
  labs(
    title = glue("Global temperature change ({min(t_data$year)} - {max(t_data$year)})")
  ) +
  theme(
    axis.text.x = element_text(color='white', margin = margin(t=5,b=10,
                                                              unit = 'pt')),
    plot.title = element_text(color='white', margin = margin(t=10,b=5, 
                                                              unit = 'pt'),
                              hjust = 0.05),
    plot.background = element_rect(fill='black')
    
  )
  
ggsave("figures/temperature_stripes_plot.png", width = 8, height = 4.5)  
