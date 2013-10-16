(function() {
  'use strict';
  angular.module('cycleApp').directive('drawModels', [
    "$window", function($window) {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          var clearCanvas, context, drawMap, requestAnimationFrame;
          requestAnimationFrame = $window.requestAnimationFrame || $window.mozRequestAnimationFrame || $window.msRequestAnimationFrame || $window.webkitRequestAnimationFrame;
          context = element[0].getContext('2d');
          clearCanvas = function() {
            context.fillStyle = "#fff";
            return context.fillRect(0, 0, +attrs.width, +attrs.height);
          };
          drawMap = function() {
            var model, _i, _len, _ref;
            clearCanvas();
            _ref = scope.$eval(attrs.drawModels);
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              model = _ref[_i];
              model.move(0, 0, +attrs.width, +attrs.height);
              model.draw(context);
            }
            return requestAnimationFrame(drawMap);
          };
          return requestAnimationFrame(drawMap);
        }
      };
    }
  ]);

}).call(this);

/*
//@ sourceMappingURL=drawModels.js.map
*/