_                            = require 'lodash'
React                        = require 'react'
PropTypes                    = require 'framework/PropTypes'
ActionStatus                 = require 'framework/enums/ActionStatus'
Observe                      = require 'framework/mixins/Observe'
CardActionListDisplayedEvent = require 'events/display/StackDisplayedEvent'
Frame                        = React.createFactory(require 'ui/common/Frame')
Icon                         = React.createFactory(require 'ui/common/Icon')
{span}                       = React.DOM

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

    {total, counts} = @getCounts()

    classes = ['progress']
    classes.push('warning') if counts[ActionStatus.Warning] > 0

    Frame {@isReady, className: classes.join(' ')},
      span {className: 'count'}, counts[ActionStatus.Complete]
      '/'
      span {className: 'count'}, total    

  getCounts: ->

    if @state.actions?
      counts = _.countBy(@state.actions, 'status')
      total = @state.actions.length
    else
      counts = {}
      total = 0

    for status in _.keys(ActionStatus)
      counts[status] = 0 unless counts[status]?

    {total, counts}

}

module.exports = CardProgressBar
