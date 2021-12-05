# frequency of reports by time

freq_model_plot <- function(dat, st1, st2, st3 = NULL, t){

#  if(st3 == "None")

  if(t == "minute"){
    st_1 <- dat %>% filter(state %in% st1) %>% group_by(minute) %>% count()
    st_2 <- dat %>% filter(state %in% st2) %>% group_by(minute) %>% count()
    st_3 <- dat %>% filter(state %in% st3) %>% group_by(minute) %>% count()
  }
  if(t == "hour"){
    st_1 <- dat %>% filter(state %in% st1) %>% group_by(hour) %>% count()
    st_2 <- dat %>% filter(state %in% st2) %>% group_by(hour) %>% count()
    st_3 <- dat %>% filter(state %in% st3) %>% group_by(hour) %>% count()
  }
  if(t == "day"){
    st_1 <- dat %>% filter(state == st1) %>% group_by(day) %>% count()
    st_2 <- dat %>% filter(state == st2) %>% group_by(day) %>% count()
    st_3 <- dat %>% filter(state == st3) %>% group_by(day) %>% count()
  }
  if(t == "month"){
    st_1 <- dat %>% filter(state %in% st1) %>% group_by(month) %>% count()
    st_2 <- dat %>% filter(state %in% st2) %>% group_by(month) %>% count()
    st_3 <- dat %>% filter(state %in% st3) %>% group_by(month) %>% count()
  }
  if(t == "year"){
    st_1 <- dat %>% filter(state == st1) %>% group_by(year) %>% count()
    st_2 <- dat %>% filter(state == st2) %>% group_by(year) %>% count()
    st_3 <- dat %>% filter(state == st3) %>% group_by(year) %>% count()
  }

  p <- ggplot(st_1, aes(x = st_1[[t]], y = n, color = st1)) +
    geom_line(size = 1.5) +
    geom_line(data = st_2, aes(x = st_2[[t]], y = n, color = st2), size = 1.5) +
    geom_line(data = st_3, aes(x = st_3[[t]], y = n, color = st3), size = 1.5) +
    theme_dark() +
    theme(plot.background = element_rect(fill = "#c1f9ea", 
                                         color = "#c1f9ea")) +
    scale_x_continuous(breaks = seq(1, max(x), by = 2)) +
    labs(title = paste("Frequency of reports by", t),
         subtitle = paste(st1, "and", st2),
         x = toTitleCase(t),
         y = paste("Frequency of reports"),
         color = "State")
  return(p)
}

