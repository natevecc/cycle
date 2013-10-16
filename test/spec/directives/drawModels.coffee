'use strict'

describe 'Directive: drawModels', () ->

  # load the directive's module
  beforeEach module 'cycleApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<draw-models></draw-models>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the drawModels directive'
