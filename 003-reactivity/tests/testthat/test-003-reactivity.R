library(shinytest2)

test_that("Test 003-reactivity app", {
  app <- AppDriver$new(
    seed = 100,
    shiny_args = list(display.mode = "normal"),
    expect_values_screenshot_args = FALSE
  )

  app$expect_values()
  app$set_inputs(dataset = "pressure")
  app$expect_values()
  app$set_inputs(dataset = "cars")
  app$set_inputs(dataset = "pressure")
  app$set_inputs(dataset = "rock")
  app$expect_values()
})
