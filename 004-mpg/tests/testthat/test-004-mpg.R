library(shinytest2)

test_that("Test 004-mpg app", {
  app <- AppDriver$new(
    seed = 100,
    shiny_args = list(display.mode = "normal"),
    options = list("shiny.json.digits" = 4),
    expect_values_screenshot_args = FALSE
  )

  app$expect_values()
  app$set_inputs(variable = "am")
  app$expect_values()
  app$set_inputs(variable = "gear")
  app$expect_values()
  app$set_inputs(outliers = FALSE)
  app$set_inputs(variable = "cyl")
  app$expect_values()
})
