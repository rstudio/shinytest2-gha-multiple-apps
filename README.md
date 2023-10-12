
# shinytest2-gha-multiple-apps

<!-- badges: start -->
<!-- badges: end -->

The goal of shinytest2-gha-multiple-apps is to provide an example of a project where multiple Shiny apps are tested with [shinytest2](https://rstudio.github.io/shinytest2/) in GitHub Actions.
This project follows the workflow laid out in [Using shinytest2 with continuous integration](https://rstudio.github.io/shinytest2/articles/use-ci.html#a-repository-with-multiple-applications).


## Setup Log

```r
library(usethis)

create_project("shinytest2-gha-multiple-apps")

# Use the example renv action from {shinytest2}
use_github_action(url = "https://github.com/rstudio/shinytest2/blob/main/actions/test-app/example-test-app-renv.yaml")
```

Added two apps from [shinycoreci](https://github.com/rstudio/shinycoreci):

* [003-reactivity](https://github.com/rstudio/shinycoreci/blob/main/inst/apps/003-reactivity/app.R)
* [004-mpg](https://github.com/rstudio/shinycoreci/blob/main/inst/apps/004-mpg/app.R)

```r
hinytest2::use_shinytest2("003-reactivity", setup = TRUE)
shinytest2::use_shinytest2_test("003-reactivity")

shinytest2::use_shinytest2("004-mpg", setup = TRUE)
shinytest2::use_shinytest2_test("004-mpg")
```

Then I initialized renv in this project.

```r
renv::init()
#> ...
#> - Lockfile written to "~/work/rstudio/shinytest2-gha-multiple-apps/renv.lock".
#> 
#> Restarting R session...
#> 
#> - Project 'shinytest2-gha-multiple-apps' loaded. [renv 1.0.3; sha: 1.0.3]
```

Then I ran the tests for the apps to get the snapshots:

```r
shinytest2::test_app("003-reactivity")
shinytest2::test_app("004-mpg")
```

Finally, I updated the `.github/workflows/example-test-app-renv.yaml` workflow to test the two apps:

```yaml
- uses: rstudio/shinytest2/actions/test-app@v1
  with:
    app-dir: |
      003-reactivity
      004-mpg
```

We now have, roughly, everything in place so I can just confirm our lockfile is up to date

```r
renv::snapshot()
#> - The lockfile is already up to date.
```

and then commit everything

```shell
git add .
git commit -m "first commit, basic project is set up"
```
