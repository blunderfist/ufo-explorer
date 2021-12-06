# linear model for when to expect a shape based on time

linear_plot_funct <- function(dat, t, s){
  
  if(t == "minute"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(minute) %>% count()
    model <- lm(n ~ minute, data = lm_data)}
  if(t == "hour"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(hour) %>% count()
    model <- lm(n ~ hour, data = lm_data)}
  if(t == "day"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(day) %>% count()
    model <- lm(n ~ day, data = lm_data)}
  if(t == "month"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(month) %>% count()
    model <- lm(n ~ month, data = lm_data)}
  if(t == "year"){
    lm_data <- dat %>% filter(shape == s) %>% group_by(year) %>% count()
    model <- lm(n ~ year, data = lm_data)}

  p <- ggplot(lm_data, aes(x = lm_data[[t]], y = n)) +
    geom_point() +
    geom_smooth()
  return(p)
}

linear_funct(data, "minute", "triangle")



linear_model <- function(t,s){
  
  lm_data <- data %>% filter(shape == s) %>% group_by(hour) %>% count()
  model <- lm(n ~ hour, data = lm_data)
  return(model)
}


linear_funct("hour", "light")




data1 <- filter(data, shape == "light") %>% group_by(hour) %>% count()
#data1[is.na(data1) | data1 == "Inf"] <- NA



lm_data <- filter(data, shape == "sphere") %>% group_by(hour) %>% count()


model <- lm(n ~ hour, data = lm_data)
model
ggplot(lm_data, aes(x = hour, y = n)) +
  geom_point() +
  geom_smooth()


lm_data <- filter(data, shape == "sphere") %>% group_by(day) %>% count()


model <- lm(n ~ day, data = lm_data)
model
ggplot(lm_data, aes(x = day, y = n)) +
  geom_point() +
  geom_smooth()


lm_data <- filter(data, shape == "sphere") %>% group_by(minute) %>% count()


model <- lm(n ~ minute, data = lm_data)
model
ggplot(lm_data, aes(x = minute, y = n)) +
  geom_point() +
  geom_smooth()

lm_data <- filter(data, shape == "sphere") %>% group_by(year) %>% count()


model <- lm(n ~ year, data = lm_data)
model
ggplot(lm_data, aes(x = year, y = n)) +
  geom_point() +
  geom_smooth()

lm_data <- filter(data, shape == "light") %>% group_by(month) %>% count()


model <- lm(n ~ month, data = lm_data)
model
ggplot(lm_data, aes(x = month, y = n)) +
  geom_point() +
  geom_smooth()

lm_data1 <- filter(data, year == 2000, month == 1, shape == "light")# %>% group_by(hour) %>% count()


model <- lm(day ~ hour, data = lm_data1)
model
ggplot(data, aes(x = hour, y = day)) +
  geom_point() +
  geom_smooth()

# if(t == "minute"){
#   lm_data <- filter(dat, shape == s) %>% group_by(minute) %>% count()
# }
# if(t == "hour"){
#   lm_data <- filter(dat, shape == s) %>% group_by(hour) %>% count()
# }
# if(t == "day"){
#   lm_data <- filter(dat, shape == s) %>% group_by(day) %>% count()
# }
# if(t == "week"){
#   lm_data <- filter(dat, shape == s) %>% mutate(week = month / 4) %>% group_by(week) %>% count()
# }
# if(t == "month"){
#   lm_data <- filter(dat, shape == s) %>% group_by(month) %>% count()
# }
# if(t == "year"){
#   lm_data <- filter(dat, shape == s) %>% group_by(year) %>% count()
# }
