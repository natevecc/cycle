'use strict';

angular.module('cycleApp')
  .directive('drawModels', [
    "$window"
    ($window) ->
      restrict: 'A'
      link: (scope, element, attrs) ->
        requestAnimationFrame = $window.requestAnimationFrame ||
          $window.mozRequestAnimationFrame ||
          $window.msRequestAnimationFrame ||
          $window.webkitRequestAnimationFrame
        context = element[0].getContext('2d');
        
        clearCanvas = () ->
          context.fillStyle = "#fff"
          context.fillRect(0, 0, +attrs.width, +attrs.height);

        drawMap = () ->
          clearCanvas()
          for model in scope.$eval(attrs.drawModels)
            model.move(0, 0, +attrs.width, +attrs.height)
            model.draw(context)
          requestAnimationFrame(drawMap)

        requestAnimationFrame(drawMap)   

  ])
