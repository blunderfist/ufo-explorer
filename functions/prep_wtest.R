# preps data for ttest or wilcoxon based on inputs and filtered data

prep_wtest <- function(filt_dat, year_true, lev = 1, co1_in, co2_in, st1_in = NULL, st2_in = NULL, ct1_in = NULL, ct2_in = NULL){
  
#if country
#if year
if(lev == 1){
  if(year_true == 1){
co1 <- filt_dat %>% count(country == co1_in, year) %>% mutate(loc = co1_in)
co1_true <- co1 %>% filter(`country == co1_in` == T) %>% mutate(true = `country == co1_in`) %>% select(loc, year, n)
co2 <- filt_dat %>% count(country == co2_in, year) %>% mutate(loc = co2_in)
co2_true <- co2 %>% filter(`country == co2_in` == T) %>% mutate(true = `country == co2_in`) %>% select(loc, year, n)
}else{
#if month
co1 <- filt_dat %>% count(country == co1_in, month) %>% mutate(loc = co1_in)
co1_true <- co1 %>% filter(`country == co1_in` == T) %>% mutate(true = `country == co1_in`) %>% select(loc, month, n)
co2 <- filt_dat %>% count(country == co2_in, month) %>% mutate(loc = co2_in)
co2_true <- co2 %>% filter(`country == co2_in` == T) %>% mutate(true = `country == co2_in`) %>% select(loc, month, n)
}
compare <- rbind(co1_true, co2_true)
}

#if state
if(lev == 2){
#if year
  if(year_true == 1){
st1 <- filt_dat %>% count(state == st1_in, year) %>% mutate(loc = st1_in)
st1_true <- st1 %>% filter(`state == st1_in` == T) %>% mutate(true = `state == st1_in`) %>% select(loc, year, n)
st2 <- filt_dat %>% count(state == st2_in, year) %>% mutate(loc = st2_in)
st2_true <- st2 %>% filter(`state == st2_in` == T) %>% mutate(true = `state == st2_in`) %>% select(loc, year, n)
}else{
#if month
st1 <- filt_dat %>% count(state == st1_in, month) %>% mutate(loc = st1_in)
st1_true <- st1 %>% filter(`state == st1_in` == T) %>% mutate(true = `state == st1_in`) %>% select(loc, month, n)
st2 <- filt_dat %>% count(state == st2_in, month) %>% mutate(loc = st2_in)
st2_true <- st2 %>% filter(`state == st2_in` == T) %>% mutate(true = `state == st2_in`) %>% select(loc, month, n)
}
compare <- rbind(st1_true, st2_true)
}

#if city
if(lev == 3){
  #if year
  if(year_true == 1){
ct1 <- filt_dat %>% count(state == st1_in, city == ct1_in, year) %>% mutate(loc_st = st1_in, loc = ct1_in)
ct1_true <- ct1 %>% filter(`state == st1_in` == T, `city == ct1_in` == T) %>% mutate(true = `state == st1_in`, true_c = `city == ct1_in`) %>% select(loc_st, loc, year, n)
ct2 <- filt_dat %>% count(state == st2_in, city == ct2_in, year) %>% mutate(loc_st = st2_in, loc = ct2_in)
ct2_true <- ct2 %>% filter(`state == st2_in` == T, `city == ct2_in` == T) %>% mutate(true = `state == st2_in`, true_c = `city == ct2_in`) %>% select(loc_st, loc, year, n)
}else{
#if month
ct1 <- filt_dat %>% count(state == st1_in, city == ct1_in, month) %>% mutate(loc_st = st1_in, loc = ct1_in)
ct1_true <- ct1 %>% filter(`state == st1_in` == T, `city == ct1_in` == T) %>% mutate(true = `state == st1_in`, true_c = `city == ct1_in`) %>% select(loc_st, loc, month, n)
ct2 <- filt_dat %>% count(state == st2_in, city == ct2_in, month) %>% mutate(loc_st = st2_in, loc = ct2_in)
ct2_true <- ct2 %>% filter(`state == st2_in` == T, `city == ct2_in` == T) %>% mutate(true = `state == st2_in`, true_c = `city == ct2_in`) %>% select(loc_st, loc, month, n)
}
compare <- rbind(ct1_true, ct2_true)
}

  return(compare)
}


