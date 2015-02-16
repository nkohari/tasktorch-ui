_                            = require 'lodash'
React                        = require 'react'
PropTypes                    = require 'framework/PropTypes'
Observe                      = require 'framework/mixins/Observe'
CardActionListDisplayedEvent = require 'events/display/StackDisplayedEvent'
Frame                        = React.createFactory(require 'ui/common/Frame')
Icon                         = React.createFactory(require 'ui/common/Icon')

CardProgressBar = React.createClass {

  displayName: 'CardProgressBar'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe('actions')]

  componentDidMount: ->
    @publish new CardActionListDisplayedEvent(@props.card.id, @props.card.actions)

  componentWillReceiveProps: (newProps) ->
    if @props.card.id != newProps.card.id
      @publish new CardActionListDisplayedEvent(@props.card.id, @props.card.actions)

  sync: (stores) ->
    {actions: stores.actions.getAllByCard(@props.card.id)}

  isReady: ->
    @state.actions?

  render: ->

    Frame {@isReady, className: 'progress'},
      Icon {name: 'action'}
      @state.actions?.length

}

module.exports = CardProgressBar
