library(tidyverse)
library(skimr)

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

select(coronavirus, country, lat, long)

#if you just want to pull up specific variables without necessarily naming them all
select(coronavirus, contains('y'))

#You can then call up just those variables first and then everything else after
select(coronavirus, contains('y'), everything())

coronavirus_us <- filter(coronavirus, country == "US")
coronavirus_us <- select(coronavirus_us, -lat, -long, -province)
#this is how we can trim the dataset to include only the variables that we want

#"|>" is the way to use the piping feature so that you don't have to keep making different objects 
#when you pipe a certain constraint into the ggplot function, you don't have to name the dataset and variables, because those already exist

coronavirus |>
  filter(type == "death", country %in% c("US", "Canada", "Mexico")) |>
  select(country, date, cases) |>
  ggplot() +
  geom_line(mapping = aes(x = date, y = cases, color = country))



# Vaccine data ------------------------------------------------------------

#when you insert a new section, you can really easily go to those different sections
vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
View(vacc)

max(vacc$date)
vacc |>
  filter(date == max(vacc$date)) |>
  select(country_region, continent_name, people_at_least_one_dose, population) |>
  mutate(vaxrate = round(people_at_least_one_dose / population, 2))

max(vacc$date)
vacc |>
  filter(date == max(vacc$date)) |>
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(doserate = doses_admin / people_at_least_one_dose) |>
  ggplot() +
  geom_histogram(mapping = aes(x = doserate))

max(vacc$date)
vacc |>
  filter(date == max(vacc$date), (doses_admin > 200000000)) |>
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(doserate = doses_admin / people_at_least_one_dose) |>
  arrange(doserate)


#in how many countries do >90% of the population have at least one dose?
max(vacc$date)
vacc |>
  filter(date == max(vacc$date)) |>
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(doseratepop = people_at_least_one_dose / population) |>
  filter(doseratepop > 0.9) |>
  arrange(-doseratepop) |>
  head(5)

top5_countries <- coronavirus |>
  filter(type == "confirmed") |>
  group_by(country) |>
  summarize(total = sum(cases)) |>
  arrange(-total) |>
  head(5) |>
  pull(country)

#"pull" function allows you to put the things that you got into a vector

coronavirus |>
  filter(type == "confirmed", country %in% top5_countries, cases >= 0) |>
  group_by(date, country) |>
  summarise(total = sum(cases)) |>
  ggplot() +
  geom_line(mapping = aes(x = date, y = total, color = country)) +
  facet_wrap(~country)




