(function() {
  'use strict';
  angular.module('cycleApp').controller('MainCtrl', [
    '$scope', function($scope) {
      var Circle, Line;
      Circle = (function() {
        function Circle(x, y, r, dx, dy, color) {
          this.x = x;
          this.y = y;
          this.r = r;
          this.dx = dx != null ? dx : 0;
          this.dy = dy != null ? dy : 0;
          this.color = color != null ? color : "#000000";
          this.type = "Circle";
        }

        Circle.prototype.draw = function(context) {
          context.beginPath();
          context.fillStyle = this.color;
          context.arc(this.x, this.y, this.r, 0, Math.PI * 2, true);
          context.closePath();
          return context.fill();
        };

        Circle.prototype.bounceX = function() {
          return this.dx = this.dx * -1;
        };

        Circle.prototype.bounceY = function() {
          return this.dy = this.dy * -1;
        };

        Circle.prototype.move = function(minWidth, minHeight, maxWidth, maxHeight) {
          this.x += this.dx;
          this.y += this.dy;
          if (this.x >= maxWidth) {
            this.dx = this.dx * -1;
            this.x = maxWidth;
          }
          if (this.x <= minWidth) {
            this.dx = this.dx * -1;
            this.x = minWidth;
          }
          if (this.y >= maxHeight) {
            this.dy = this.dy * -1;
            this.y = maxHeight;
          }
          if (this.y <= minHeight) {
            this.dy = this.dy * -1;
            return this.y = minHeight;
          }
        };

        return Circle;

      })();
      Line = (function() {
        function Line(startX, startY, endX, endY, dx, dy, color) {
          this.startX = startX;
          this.startY = startY;
          this.endX = endX;
          this.endY = endY;
          this.dx = dx != null ? dx : 0;
          this.dy = dy != null ? dy : 0;
          this.color = color != null ? color : "#000000";
          this.type = "Line";
        }

        Line.prototype.draw = function(context) {
          context.beginPath();
          context.fillStyle = this.color;
          context.moveTo(this.startX, this.startY);
          context.lineTo(this.endX, this.endY);
          return context.stroke();
        };

        Line.prototype.move = function(minWidth, minHeight, maxWidth, maxHeight) {
          this.startX += this.dx;
          this.startY += this.dy;
          this.endX += this.dx;
          this.endY += this.dy;
          if (this.startX >= maxWidth || this.endX >= maxWidth) {
            this.dx = this.dx * -1;
          }
          if (this.startX <= minWidth || this.endX <= minWidth) {
            this.dx = this.dx * -1;
          }
          if (this.startY >= maxHeight || this.endY >= maxHeight) {
            this.dy = this.dy * -1;
          }
          if (this.startY <= minHeight || this.endY <= minHeight) {
            return this.dy = this.dy * -1;
          }
        };

        return Line;

      })();
      $scope.newModelType = "Circle";
      $scope.addNewModel = function() {
        switch ($scope.newModelType) {
          case "Circle":
            return $scope.models.push(new Circle(10, 10, 5));
          case "Line":
            return $scope.models.push(new Line(10, 10, 20, 20));
        }
      };
      $scope.removeModel = function(model) {
        return $scope.models = _($scope.models).without(model);
      };
      return $scope.models = [new Circle(10, 10, 5)];
    }
  ]);

}).call(this);

/*
//@ sourceMappingURL=main.js.map
*/