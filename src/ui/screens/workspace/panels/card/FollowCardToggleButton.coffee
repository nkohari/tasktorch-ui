_                       = require 'lodash'
React                   = require 'react'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
Pure                    = require 'ui/framework/mixins/Pure'
classSet                = require 'common/util/classSet'
UserFollowedCardEvent   = require 'events/ui/UserFollowedCardEvent'
UserUnfollowedCardEvent = require 'events/ui/UserUnfollowedCardEvent'
Button                  = React.createFactory(require 'ui/common/Button')
Frame                   = React.createFactory(require 'ui/common/Frame')

FollowCardToggleButton = React.createClass {

  displayName: 'FollowCardToggleButton'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  mixins: [Actor, Pure]

  getInitialState: ->
    {active: _.contains(@props.card.followers, @props.currentUser.id)}

  componentWillReceiveProps: (newProps) ->
    @setState {active: _.contains(newProps.card.followers, newProps.currentUser.id)}

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
        @publish new UserFollowedCardEvent(@props.card.id, @props.currentUser.id)
      else
        @publish new UserUnfollowedCardEvent(@props.card.id, @props.currentUser.id)

}

module.exports = FollowCardToggleButton
