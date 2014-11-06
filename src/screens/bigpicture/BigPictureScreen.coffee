_                     = require 'lodash'
React                 = require 'react'
Router                = require 'react-router'
ActiveUrl             = require 'mixins/ActiveUrl'
Flux                  = require 'mixins/Flux'
BigPictureEnvironment = require './BigPictureEnvironment'
BigPictureUrl         = require './BigPictureUrl'
BigPictureSidebar     = React.createFactory(require './components/BigPictureSidebar')
{div}                 = React.DOM

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [
    Flux()
    ActiveUrl(BigPictureUrl)
  ]

  getDefaultProps: ->
    {controller: BigPictureEnvironment.createController()}

  componentWillMount: ->
    @getController().setOrganization(@getActiveUrl().organizationId)

  render: ->

    div {className: 'bigpicture screen'}, [
      BigPictureSidebar {key: 'sidebar'}
    ]

}

module.exports = BigPictureScreen
