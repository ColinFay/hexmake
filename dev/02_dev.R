# Building a Prod-Ready, Robust Shiny Application.
# 
# Each step is optional. 
# 

# 2. All along your project

## 2.1 Add modules
## 
golem::add_module( name = "main" ) # Name of the module
golem::add_module( name = "left" ) # Name of the module
golem::add_module( name = "binder" ) # Name of the module
golem::add_module( name = "formals_to_mod" ) # Name of the module
golem::add_module( name = "pkg_name" ) # Name of the module
golem::add_module( name = "image" ) # Name of the module
golem::add_module( name = "manip_image" ) # Name of the module
golem::add_module( name = "hexa" ) # Name of the module
golem::add_module( name = "spotlight" ) # Name of the module
golem::add_module( name = "url" ) # Name of the module
golem::add_module( name = "rendering" ) # Name of the module
golem::add_module( name = "dl" ) # Name of the module
golem::add_module( name = "restore" ) # Name of the module
golem::add_module( name = "right" ) # Name of the module
golem::add_module( name = "about" ) # Name of the module
golem::add_module( name = "my_hexes" ) # Name of the module
golem::add_module( name = "guided_tour", fct = "cicerone") # Name of the module

usethis::use_r("R6")
usethis::use_r("triggers")

golem::add_fct("mongo")
golem::add_fct("assert")

## 2.2 Add dependencies


usethis::use_package( "hexSticker" ) # To call each time you need a new package
usethis::use_package( "sysfonts" ) # To call each time you need a new package
usethis::use_package( "magick" ) # To call each time you need a new package
usethis::use_package( "fs" ) # To call each time you need a new package
usethis::use_package( "R6" ) # To call each time you need a new package
usethis::use_package( "attempt" ) # To call each time you need a new package

## 2.3 Add tests

usethis::use_test( "app" )

## 2.4 Add a browser button

golem::browser_button()

## 2.5 Add external files

golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

# 3. Documentation

## 3.1 Vignette
usethis::use_vignette("hexmas")
devtools::build_vignettes()

## 3.2 Code coverage
## You'll need GitHub there
usethis::use_github()
usethis::use_travis()
usethis::use_appveyor()

# You're now set! 
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
