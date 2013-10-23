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

      class AnimatedEntity extends Entity
        frames = 0
        standStill =
          x: 32
          y: 0
        downWalk1 =
          x: 0
          y: 0
        downWalk2 =
          x: 64
          y: 0

        walkUpSprite1 = 
          x: 0
          y: 96
        walkUpSprite2 = 
          x: 64
          y: 96

        walkRight1 =
          x: 0
          y: 64
        walkRight2 =
          x: 64
          y: 64

        walkLeft1 =
          x: 0
          y: 32
        walkLeft2 = 
          x: 64
          y: 32

        tick = true
        draw: (context) ->
          if @isLoaded
            frames = frames + 1

          if frames is 85
            tick = not tick
            frames = 0
          
          #if change in y is 0 or if change in x is 0 stand still
          if @dy is 0 and @dx is 0
            spriteX = standStill.x
            spriteY = standStill.y
          # if change in y is greater than 0 walk down
          if @dy > 0
            spriteX = if tick then downWalk1.x else downWalk2.x
            spriteY = if tick then downWalk1.y else downWalk2.y
          # if change in y is less than zero walk up
          if @dy < 0
            spriteX = if tick then walkUpSprite1.x else walkUpSprite2.x
            spriteY = if tick then walkUpSprite1.y else walkUpSprite2.y
          # if change in x is greater than zero walk right
          if @dx > 0
            spriteX = if tick then walkRight1.x else walkRight2.x
            spriteY = if tick then walkRight1.y else walkRight2.y
          # if change in x is less than zero walk left left
          if @dx < 0
            spriteX = if tick then walkLeft1.x else walkLeft2.x
            spriteY = if tick then walkLeft1.y else walkLeft2.y

          context.drawImage(@image, spriteX, spriteY, 32, 32, @x, @y, @width, @height);

      class AnimatedEntity2 extends Entity
        frames = 0
        standStill =
          x: 10 * 32
          y: 0
        downWalk1 =
          x: 9 * 32
          y: 0
        downWalk2 =
          x: 12*32
          y: 0

        walkUpSprite1 = 
          x: 9*32
          y: 3*32
        walkUpSprite2 = 
          x: 11*32
          y: 3*32

        walkRight1 =
          x: 9*32
          y: 2*32
        walkRight2 =
          x: 11*32
          y: 2*32 

        walkLeft1 =
          x: 9*32
          y: 1*32
        walkLeft2 = 
          x: 11*32
          y: 1*32

        tick = true
        draw: (context) ->
          if @isLoaded
            frames = frames + 1

          if frames is 85
            tick = not tick
            frames = 0
          
          #if change in y is 0 or if change in x is 0 stand still
          if @dy is 0 and @dx is 0
            spriteX = standStill.x
            spriteY = standStill.y
          # if change in y is greater than 0 walk down
          if @dy > 0
            spriteX = if tick then downWalk1.x else downWalk2.x
            spriteY = if tick then downWalk1.y else downWalk2.y
          # if change in y is less than zero walk up
          if @dy < 0
            spriteX = if tick then walkUpSprite1.x else walkUpSprite2.x
            spriteY = if tick then walkUpSprite1.y else walkUpSprite2.y
          # if change in x is greater than zero walk right
          if @dx > 0
            spriteX = if tick then walkRight1.x else walkRight2.x
            spriteY = if tick then walkRight1.y else walkRight2.y
          # if change in x is less than zero walk left left
          if @dx < 0
            spriteX = if tick then walkLeft1.x else walkLeft2.x
            spriteY = if tick then walkLeft1.y else walkLeft2.y

          context.drawImage(@image, spriteX, spriteY, 32, 32, @x, @y, @width, @height);

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
            $scope.models.push(new AnimatedEntity(25, 25, 32, 32, "images/sprites.png"))
          when "Sprite2"
            $scope.models.push(new AnimatedEntity2(25, 25, 32, 32, "images/sprites.png"))

      $scope.removeModel = (model) ->
        $scope.models = _($scope.models).without model

      $scope.models = [
        new Circle(10, 10, 5)
      ]
  ]
