library(rCharts)
library(rMaps)
library(RColorBrewer)
library(plyr)
indMaps <- list()
indMaps$new <- function(){
  map <- Datamaps$new()
  map$set(geographyConfig = setNames('PATH TO INDIA.TOPOJSON',"dataUrl"),width=300,height=500)
  map$templates$script <- "PATH TO chartINDIA.html" #have link to json and mercator projection
  map
}

indChoropleth<-function (x, data, pal = "Blues", ncuts = 5, animate = NULL, 
                         play = F, map = "india", legend = TRUE, labels = TRUE, ...) 
{
  d <- indMaps$new()
  fml = lattice::latticeParseFormula(x, data = data)
  data = transform(data, fillKey = cut(fml$left, quantile(fml$left, 
                                                          seq(0, 1, 1/ncuts)), ordered_result = TRUE))
  fillColors = brewer.pal(ncuts, pal)
  d$set(scope = map, fills = as.list(setNames(fillColors, levels(data$fillKey))), 
        legend = legend, labels = labels, ...)
  if (!is.null(animate)) {
    range_ = summary(data[[animate]])
    data = dlply(data, animate, function(x) {
      y = toJSONArray2(x, json = F)
      names(y) = x[,fml$right.name]
      return(y)
    })
    d$set(bodyattrs = "ng-app ng-controller='rChartsCtrl'")
    d$addAssets(jshead = "http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular.min.js")
    if (play == T) {
      d$setTemplate(chartDiv = sprintf("\n        <div class='container'>\n         <button ng-click='animateMap()'>Play</button>\n         <span ng-bind='year'></span>\n         <div id='{{chartId}}' class='rChart datamaps'></div>\n        </div>\n        <script>\n          function rChartsCtrl($scope, $timeout){\n            $scope.year = %s;\n              $scope.animateMap = function(){\n              if ($scope.year > %s){\n                return;\n              }\n              map{{chartId}}.updateChoropleth(chartParams.newData[$scope.year]);\n              $scope.year += 1\n              $timeout($scope.animateMap, 1000)\n            }\n          }\n       </script>", 
                                       range_[1], range_[6]))
    }
    else {
      d$setTemplate(chartDiv = sprintf("\n        <div class='container'>\n          <input id='slider' type='range' min=%s max=%s ng-model='year' width=200>\n          <span ng-bind='year'></span>\n          <div id='{{chartId}}' class='rChart datamaps'></div>          \n        </div>\n        <script>\n          function rChartsCtrl($scope){\n            $scope.year = %s;\n            $scope.$watch('year', function(newYear){\n              map{{chartId}}.updateChoropleth(chartParams.newData[newYear]);\n            })\n          }\n       </script>", 
                                       range_[1], range_[6], range_[1]))
    }
    d$set(newData = data, data = data[[1]])
  }
  else {
    d$set(data = dlply(data, fml$right.name))
  }
  return(d)
}

states<-c("IND-2427","IND-2428","IND-2429","IND-2430","IND-2431","IND-2441","IND-2442","IND-2443","IND-2444","IND-2445","IND-2446","IND-2447","IND-2474","IND-2477","IND-2478","IND-2479","IND-2489","IND-3249","IND-3250","IND-3253","IND-3254","IND-3256","IND-3257","IND-3258","IND-3259","IND-3260","IND-3261","IND-3262","IND-3263","IND-3264","IND-3265","IND-3299","IND-3300","IND-3301","IND-3504")
dat<-data.frame(Year=rep(c(2010,2011,2012),each=35),State=rep(states,3),Crime=sample(c(1000:10000000),105))
indChoropleth(Crime~State,dat,animate="Year")
