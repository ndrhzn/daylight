library(ggplot2)
library(viridis)

source("~/R/daylight/02_parse_data.R")
df <- read.csv("~/R/daylight/data/kyiv.csv", stringsAsFactors = F)
df <- parse_data(df)

ggplot(df)+
  geom_linerange(aes(date, ymin = start, ymax = end,
                     color = end - start),
                 alpha = 0.9, size = 1.5)+
  geom_text(data = df[df$date == min(df$date),],
                  aes(x = date, y = start, label = "початок світлового дня",
                      family = "Ubuntu Condensed", label.size = 10, fontface = "plain"),
                  hjust = 0, vjust = 5, colour = "#5D646F")+
  geom_text(data = df[df$date == min(df$date),],
            aes(x = date, y = end, label = "кінець світлового дня",
                family = "Ubuntu Condensed", label.size = 10, fontface = "plain"),
            hjust = 0, vjust = -5, colour = "#5D646F")+
  geom_text(data = df[df$date == as.Date("2016-03-27"),],
            aes(x = date, y = end, label = "перехід на літній час",
                family = "Ubuntu Condensed", label.size = 10, fontface = "plain"),
            hjust = 0, vjust = -4.5, colour = "#5D646F")+
  geom_text(data = df[df$date == as.Date("2016-10-30"),],
            aes(x = date, y = end, label = "перехід на зимовий час",
                family = "Ubuntu Condensed", label.size = 10, fontface = "plain"),
            hjust = 0, vjust = -4.5, colour = "#5D646F")+
  scale_color_viridis(begin = 0.2, end = 0.8)+
  scale_x_date(name = NULL, breaks = as.Date(c("2016-03-01",
                                               "2016-06-01", "2016-09-01",
                                               "2016-12-01")), 
               date_labels = "%B", minor_breaks = NULL)+
  scale_y_datetime(date_breaks = "2 hours", date_labels = "%H",
                   minor_breaks = NULL)+
  guides(color = guide_colorbar(title = "Тривалість світлового дня, годин", 
                                title.position = "top"))+
  labs(title = "Тривалість світлового дня у Києві",
       subtitle = "\nНайкоротший світловий день у 2016 році тривав 8 годин, а найдовший - 16 годин 45 хвилин",
       caption = "\nДані: timeanddate.com")+
  theme_minimal(base_family = "Ubuntu Condensed")+
  theme(text = element_text(family = "Ubuntu Condensed", color = "#3A3F4A"),
        legend.position = "top",
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 12),
        legend.key.height = unit(2, "pt"),
        legend.key.width = unit(100, "pt"),
        axis.text.x = element_text(face = "plain", size = 12),
        axis.text.y = element_text(face = "plain", size = 12),
        axis.title = element_blank(),
        panel.grid.major = element_line(size = 0.25, linetype = "dotted", color = "#5D646F"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(face = "bold", size = 36, margin = margin(b = 10)),
        plot.subtitle = element_text(size = 16, margin = margin(b = 20)),
        plot.caption = element_text(size = 14, margin = margin(b = 10, t = 10), color = "#5D646F"),
        plot.background = element_rect(fill = "#EFF2F4"),
        plot.margin = unit(c(2, 2, 2, 2), "cm"))
