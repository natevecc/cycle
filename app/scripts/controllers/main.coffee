'use strict'

angular.module('cycleApp')
  .controller 'MainCtrl', [
    '$scope'
    ($scope) ->
      class Entity
        constructor: (@x, @y, @height, @width, @imageUrl) ->
          @type = "MJ"
          @image = new Image()
          @image.onload = () =>
            @isLoaded = true
          @image.src = @imageUrl
          @isLoaded = false
          @dx = 0
          @dy = 0
        move: (minWidth, minHeight, maxWidth, maxHeight) ->
          @x += @dx
          @y += @dy
          if @x >= maxWidth
            @dx = @dx * -1
            @x = maxWidth
          if @x <= minWidth
            @dx = @dx * -1
            @x = minWidth
          if @y + @height >= maxHeight
            @dy = @dy * -1
            @y = maxHeight
          if @y <= minHeight
            @dy = @dy * -1
            @y = minHeight
        draw: (context) ->
          if @isLoaded
            context.drawImage(@image, @x, @y)

      class Circle 
        constructor: (@x, @y, @r, @dx = 0, @dy = 0, @color="#000000") ->
          @type="Circle"
        # Each circle object knows how to draw itself  
        draw: (context) ->
          context.beginPath()
          context.fillStyle = @color
          context.arc @x, @y, @r, 0, Math.PI * 2, true
          context.closePath()
          context.fill()        
        # If we want to change directions horizontally
        bounceX: ->
          @dx = @dx * -1
        bounceY: ->
          @dy = @dy * -1
        # Moves the object by applying it's velocity to the current position 
        move: (minWidth, minHeight, maxWidth, maxHeight) ->
          @x += @dx
          @y += @dy
          if @x >= maxWidth
            @dx = @dx * -1
            @x = maxWidth
          if @x <= minWidth
            @dx = @dx * -1
            @x = minWidth
          if @y >= maxHeight
            @dy = @dy * -1
            @y = maxHeight
          if @y <= minHeight
            @dy = @dy * -1
            @y = minHeight

      class Line 
        constructor: (@startX, @startY, @endX, @endY, @dx = 0, @dy = 0, @color="#000000") ->
          @type="Line"
        # Each circle object knows how to draw itself  
        draw: (context) ->
          context.beginPath()
          context.fillStyle = @color
          context.moveTo(@startX, @startY);
          context.lineTo(@endX, @endY);
          context.stroke();     
        # Moves the object by applying it's velocity to the current position 
        move: (minWidth, minHeight, maxWidth, maxHeight) ->
          @startX += @dx
          @startY += @dy
          @endX += @dx
          @endY += @dy
          if @startX >= maxWidth or @endX >= maxWidth
            @dx = @dx * -1
          if @startX <= minWidth or @endX <= minWidth
            @dx = @dx * -1
          if @startY >= maxHeight or @endY >= maxHeight
            @dy = @dy * -1
          if @startY <= minHeight or @endY <= minHeight
            @dy = @dy * -1

      $scope.newModelType = "Circle"

      $scope.addNewModel = () ->
        switch $scope.newModelType
          when "Circle"
            $scope.models.push(new Circle(10, 10, 5))
          when "Line"
            $scope.models.push(new Line(10, 10, 20, 20))
          when "MJ"
            $scope.models.push(new Entity(400, 400, 200, 200, "images/mj1Small.jpg"))

      $scope.removeModel = (model) ->
        $scope.models = _($scope.models).without model

      $scope.models = [
        new Circle(10, 10, 5)
      ]
  ]
