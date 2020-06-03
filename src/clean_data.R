library(tidyverse)

# Read in the data --------------------------------------------------------
rm(list = ls())
drinks        <- read_csv("data/drinks.csv")
boston_drinks <- read_csv("data/boston_drinks.csv")

df_drinks <- drinks %>% 
  dplyr::select(!c(date_modified, 
                   id_drink,
                   video,
                   iba
                   )) %>% 
  mutate(alcoholic = ifelse(alcoholic == "Alcoholic", TRUE, FALSE)) %>%
  mutate_if(is.character, as.factor) %>% 
  # mutate(measure_number = str_extract(measure, "[:digit:]+") %>% as.integer,
  #        measure_number2 = str_extract(measure, "\\S+"),
  #        measure_unit   = str_extract(measure, "[:alpha:]+"),
  #        measure_unit2   = str_extract(measure, "[^ ]* (.*)")) %>% 
  group_by(row_id) %>% add_tally(name = "num_of_ingredients")
  # mutate(num_of_ingredients = as.factor(num_of_ingredients))

pivot_longer(
  df_drinks,
  cols = ingredient
)

df_drinks




names(mtcars)





datatable(
  cbind(' ' = '&oplus;', df_drinks), escape = -2,
  options = list(
    columnDefs = list(
      list(visible = FALSE, targets = c(8, 9, 10)),
      # list(visible = FALSE, targets = c(0, 2, 3)),
      list(orderable = FALSE, className = 'details-control', targets = 1)
    )
  ),
  callback = JS("
  table.column(1).nodes().to$().css({cursor: 'pointer'});
  var format = function(d) {
    return '<div style=\"background-color:#eee; padding: .5em;\"> Model: ' +
            d[8] + ', mpg: ' + d[9] + ', cyl: ' + d[10] + '</div>';
  };
  table.on('click', 'td.details-control', function() {
    var td = $(this), row = table.row(td.closest('tr'));
    if (row.child.isShown()) {
      row.child.hide();
      td.html('&oplus;');
    } else {
      row.child(format(row.data())).show();
      td.html('&CircleMinus;');
    }
  });"
  ))
