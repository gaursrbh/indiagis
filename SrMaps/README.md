# Changes made to original rMaps Package

##ichoropleth function

1. Changed scope to "india" (objects in india.topojson file)

2. Setting names 
```R
names(y) = x[,fml$right.name]
```

##HTML Template
3. Geoconfig changed to point to custom topojson

4. Projection changed to Mercator


======
###All of above could/should be achieved using map$set. Working on same.
