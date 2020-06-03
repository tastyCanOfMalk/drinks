library(shiny)
library(shinydashboard)
library(DT)

source("src/clean_data.R")

ui <- dashboardPage(

    dashboardHeader(title = "Drink Selector"),

    dashboardSidebar(

        radioButtons("drink_type",
                     label = h3("Drink type"),
                     choices = list(
                         "Alcoholic" = TRUE,
                         "Non-alcoholic" = FALSE
                         ),
                     selected = TRUE)

    ),

    dashboardBody(
        
        fluidRow(
            box(width = 6,
                selectInput("drink_category", 
                                   label = h3("Category"), 
                                   choices = list(
                                       "Beer"                 = "Beer",
                                       "Cocktail"             = "Cocktail",
                                       "Cocoa"                = "Cocoa",
                                       "Coffee / Tea"         = "Coffee / Tea",
                                       "Homemade Liqueur"     = "Homemade Liqueur",
                                       "Milk / Float / Shake" = "Milk / Float / Shake",
                                       "Ordinary Drink"       = "Ordinary Drink",
                                       "Other / Unknown"      = "Other/Unknown",
                                       "Punch / Party Drink"  = "Punch / Party Drink",
                                       "Shot"                 = "Shot",
                                       "Soft Drink / Soda"    = "Soft Drink / Soda"
                                       ),
                                   selected = "Cocktail"
                            )
                ),
            
            box(width = 6,
                sliderInput("num_ingredients",
                            label = h3("Number of ingredients"),
                            min = 1,
                            max = 11,
                            value = c(1, 11))
                )
            ),
        
        fluidRow(
            box(width = 12,
                verbatimTextOutput("num_ingredients")
                )
        ),
        
        fluidRow(
            box(width = 12,
                tableOutput("drink_list"))
        )

    )
)

server <- function(input, output) {
    
    drink_list <- reactive({
        df_drinks %>% 
            dplyr::filter(alcoholic == input$drink_type, 
                          category  == input$drink_category, 
                          (num_of_ingredients >= input$num_ingredients[1] &
                               num_of_ingredients <= input$num_ingredients[2])) %>%
            dplyr::select(!c(alcoholic))
        })
    
    output$drink_list <- renderTable({
        drink_list()
        })

    # output$num_ingredients_low <- renderPrint({
    #     input$num_ingredients[1]
    # })
    # 
    # output$num_ingredients_hi <- renderPrint({
    #     input$num_ingredients[2]
    # })
    
    output$value <- renderPrint({
        input$drink_type
        })
    
    output$value <- renderPrint({
        input$checkGroup
        })
    

}

shinyApp(ui, server)
