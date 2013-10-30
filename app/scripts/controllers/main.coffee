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
          if @x + @width >= maxWidth
            @dx = @dx * -1
            @x = maxWidth - @width
          if @x <= minWidth
            @dx = @dx * -1
            @x = minWidth
          if @y + @height >= maxHeight
            @dy = @dy * -1
            @y = maxHeight - @height
          if @y <= minHeight
            @dy = @dy * -1
            @y = minHeight
        draw: (context) ->
          if @isLoaded
            context.drawImage(@image, @x, @y)

      class Sprite extends Entity
        previousPosition = 
          x: 0
          y: 0
        constructor: (@x, @y, @height, @width, @imageUrl, @spriteOptions) ->
          super(@x, @y, @height, @width, @imageUrl)
          @type = "Sprite"
          previousPosition.x = @x
          previousPosition.y = @y
          previousDirection = 'down' # 'up'|'down'|'left'|'right'|'none'
        frames = 0
        tick = false
        draw: (context) ->
          if @isLoaded
            frames = frames + 1
            
            if frames is 60
              tick = not tick
              frames = 0
            
            #if change in y is 0 or if change in x is 0 stand still
            if @dy is 0 and @dx is 0
              sprite = @spriteOptions[previousDirection] || @spriteOptions['down'] # default to down
            # if change in y is greater than 0 walk down
            if @dy > 0
              sprite = @spriteOptions.down.action[tick%2]
              previousDirection = 'down'
            # if change in y is less than zero walk up
            if @dy < 0
              sprite = @spriteOptions.up.action[tick%2]
              previousDirection = 'up'
            # if change in x is greater than zero walk right
            if @dx > 0
              sprite = @spriteOptions.right.action[tick%2]
              previousDirection = 'right'
            # if change in x is less than zero walk left left
            if @dx < 0
              sprite = @spriteOptions.left.action[tick%2]
              previousDirection = 'left'

            previousPosition.x = @x
            previousPosition.y = @y

            context.drawImage(@image, sprite.x, sprite.y, @height, @width, @x, @y, @width, @height);


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
            $scope.models.push(new Entity(25, 25, 200, 200, "images/mj1Small.jpg"))
          when "Sprite"
            spriteOptions =
              up:
                x: 0
                y: 0
                action: [
                  x: 0
                  y: 96
                ,
                  x: 64
                  y: 96
                ]
              down:
                x: 32
                y: 0
                action: [
                  x: 0
                  y: 0
                ,
                  x: 64
                  y: 0
                ]
              left:
                x: 32
                y: 0
                action: [
                  x: 0
                  y: 32
                ,
                  x: 64
                  y: 32
                ]
              right:
                x: 32
                y: 0
                action: [
                  x: 0
                  y: 64
                ,
                  x: 64
                  y: 64
                ]
            $scope.models.push(new Sprite(25, 25, 32, 32, "images/sprites.png", spriteOptions))

      $scope.removeModel = (model) ->
        $scope.models = _($scope.models).without model

      $scope.models = [
        new Circle(10, 10, 5)
      ]
  ]
