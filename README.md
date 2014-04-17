IndiaGis
========

INDIA GIS - Prepare shp, geojson, topojson files - specific to India


### Steps followed to generate Topojson files above

1. Download shp files from http://www.naturalearthdata.com/downloads/10m-cultural-vectors/

2. Convert shp files to GeoJSON and TopoJSON using [instructions](http://datamaps.markmarkoh.com/using-custom-map-data-w-datamaps/) from [DataMaps](datamaps.github.io) Author Mark DiMarco

3. Disputed Territories and Other manual changes to highlight some areas(Union Territories) performed at [geojson.io](http://geojson.io)

4. Lite version created at [MapShaper](http://www.mapshaper.org/) (Take care - IDs will be lost, Need to check [Distillery](http://shancarter.github.io/distillery/) as alternative)


### Using the Map 

The inspiration to generate this file was [rMaps](http://rmaps.github.io/) Package for R 

Use code in SrMaps folder to combine the customized map for India with rMaps.
The R code and HTML template are minor variant to accomodate new map, scope and projection




