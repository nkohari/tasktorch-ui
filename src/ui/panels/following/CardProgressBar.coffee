_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
ActionStatus = require 'data/enums/ActionStatus'
CachedState  = require 'ui/framework/mixins/CachedState'
Pure         = require 'ui/framework/mixins/Pure'
Frame        = React.createFactory(require 'ui/common/Frame')
Icon         = React.createFactory(require 'ui/common/Icon')
{span}       = React.DOM

CardProgressBar = React.createClass {

  displayName: 'CardProgressBar'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Pure]

  getCachedState: (cache) -> {
    actions: cache('actionsByCard').get(@props.card.id)
  }

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

    actions = @state.actions

    if actions?.length > 0
      counts = _.countBy(actions, 'status')
      total  = actions.length
    else
      counts = {}
      total  = 0

    for status in _.keys(ActionStatus)
      counts[status] = 0 unless counts[status]?

    {total, counts}

}

module.exports = CardProgressBar
