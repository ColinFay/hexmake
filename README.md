
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hexmake

Golem app available at <https://connect.thinkr.fr/hexmake/>

## Use it with a mongo db

If you want to use a mongo db as a backend to store hexes, you can plug
it with a docker image.

``` bash
docker run -v /mongo/data/db:/data/db -v /mongo/data/dump:/dump -p 12334:27017 -d --name mongohexmake -e MONGO_INITDB_ROOT_USERNAME=myuser -e MONGO_INITDB_ROOT_PASSWORD=mypassword mongo:3.4 
```

Then set a series of env variables with the infos (or use the one from
your prod env).

``` r
Sys.setenv("MONGOPORT" = 12334)
Sys.setenv("MONGOURL" = "127.0.0.1")
Sys.setenv("MONGODB" = "hex")
Sys.setenv("MONGOCOLLECTION" = "make")
Sys.setenv("MONGOUSER" = "myuser")
Sys.setenv("MONGOPASS" = "mypassword")
```

And run

``` r
hexmake::run_app(with_mongo = TRUE)
```

Please note that the ‘hexmake’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
