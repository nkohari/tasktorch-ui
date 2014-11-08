_             = require 'lodash'
React         = require 'react'
Router        = require 'react-router'
Flux          = require 'mixins/Flux'
ActiveUrl     = require 'mixins/ActiveUrl'
BigPictureUrl = require '../BigPictureUrl'
Panel         = React.createFactory(require 'common/Panel')
{div, ul}     = React.DOM

UserQueuePanel = React.createClass {

  displayName: 'UserQueuePanel'

  mixins: [
    Flux('cards')
    ActiveUrl(BigPictureUrl)
  ]

  propTypes:
    userId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    return {
      user: stores.users.getUser(@props.userId)
    }

  componentWillReceiveProps: (newProps) ->
    @loadUser(newProps.userId) if @props.userId != newProps.userId

  componentWillMount: ->
    @loadUser(@props.userId)

  loadUser: (userId) ->
    controller = @getController()
    controller.loadUser(userId)

  render: ->

    # TODO: Proper loading indicator
    unless @state.user?
      return div {}, ["Loading"]

    Panel {
      panelTitle:  @state.user.name
      className:   'user'
      style:       {zIndex: 99 - @props.position}
      icon:        'user'
    }, [
    ]

}

module.exports = UserQueuePanel
