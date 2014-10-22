React = require 'react'

ActiveUrl = (modelType) ->

  return {

    contextTypes:
      activeRoutes: React.PropTypes.array.isRequired
      activeParams: React.PropTypes.object.isRequired
      activeQuery:  React.PropTypes.object.isRequired
      isActive:     React.PropTypes.func.isRequired

    getActiveUrl: ->
      new modelType(@context.activeParams, @context.activeQuery)

  }

module.exports = ActiveUrl
