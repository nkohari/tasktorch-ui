_                           = require 'lodash'
React                       = require 'react'
Router                      = require 'react-router'
ActiveUrl                   = require 'mixins/ActiveUrl'
Flux                        = require 'mixins/Flux'
BigPictureControllerFactory = require './BigPictureControllerFactory'
BigPictureUrl               = require './BigPictureUrl'
BigPictureSidebar           = React.createFactory(require './components/BigPictureSidebar')
{div}                       = React.DOM

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [
    Flux()
    ActiveUrl(BigPictureUrl)
  ]

  createController: ->
    BigPictureControllerFactory.createController(@props.params.organizationId, @props.eventBus)

  render: ->

    div {className: 'bigpicture screen'}, [
      BigPictureSidebar {key: 'sidebar'}
    ]

}

module.exports = BigPictureScreen
