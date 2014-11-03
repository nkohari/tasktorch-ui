React = require 'react'

ActiveUrl = (modelType) ->

  return {

    contextTypes:
      activeRoutes: React.PropTypes.array.isRequired
      activeParams: React.PropTypes.object.isRequired
      activeQuery:  React.PropTypes.object.isRequired
      isActive:     React.PropTypes.func.isRequired

    getActiveUrl: ->
      new modelType(@context.activeRoutes, @context.activeParams, @context.activeQuery)

    isActive: (route) ->
      @context.isActive(route)

  }

module.exports = ActiveUrl
