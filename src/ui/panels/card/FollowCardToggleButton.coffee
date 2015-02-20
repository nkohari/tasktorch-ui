_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
classSet            = require 'framework/util/classSet'
FollowCardRequest   = require 'requests/FollowCardRequest'
UnfollowCardRequest = require 'requests/UnfollowCardRequest'
Button              = React.createFactory(require 'ui/common/Button')
Frame               = React.createFactory(require 'ui/common/Frame')

FollowCardToggleButton = React.createClass {

  displayName: 'FollowCardToggleButton'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  mixins: [Observe()]

  getInitialState: ->
    {active: @isActive()}

  componentWillReceiveProps: ->
    @setState {active: @isActive()}

  isActive: ->
    _.contains(@props.card.followers, @props.currentUser.id)

  render: ->

    classes = classSet [
      'follow-toggle'
      'active' if @state.active
    ]

    icon = if @state.active then 'follow' else 'follow-empty'

    Button {icon, className: classes, @onClick}

  onClick: ->
    active = !@state.active
    @setState {active}, =>
      if active
        @execute new FollowCardRequest(@props.card, @props.currentUser.id)
      else
        @execute new UnfollowCardRequest(@props.card, @props.currentUser.id)

}

module.exports = FollowCardToggleButton
