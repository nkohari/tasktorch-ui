_                     = require 'lodash'
React                 = require 'react'
Router                = require 'react-router'
ActiveUrl             = require '../mixins/ActiveUrl'
Flux                  = require '../mixins/Flux'
BigPictureEnvironment = require './BigPictureEnvironment'
BigPictureUrl         = require './BigPictureUrl'
PanelGroup            = React.createFactory(require '../common/PanelGroup')
BigPictureSidebar     = React.createFactory(require './components/BigPictureSidebar')
UserQueuePanel        = React.createFactory(require './components/UserQueuePanel')
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
    controller = @getController()
    controller.setOrganization(@getActiveUrl().organizationId)
    controller.loadTeams()

  render: ->

    url = @getActiveUrl()
    position = 0
    userPanels = _.map url.users, (userId) =>
      UserQueuePanel {key: "user-#{userId}", userId, position: position++}

    div {className: 'big-picture screen'}, [
      BigPictureSidebar {key: 'sidebar'}
      PanelGroup {key: 'user-panels'}, userPanels
    ]

}

module.exports = BigPictureScreen
