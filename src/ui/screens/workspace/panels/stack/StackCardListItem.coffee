React          = require 'react/addons'
classSet       = require 'common/util/classSet'
StackType      = require 'data/enums/StackType'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Navigator      = require 'ui/framework/mixins/Navigator'
CardPanelState = require 'ui/screens/workspace/panels/card/CardPanelState'
Link           = React.createFactory(require 'ui/common/Link')
ListItem       = React.createFactory(require 'ui/common/ListItem')
StackCard      = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCard')
{li}           = React.DOM

StackCardListItem = React.createClass {

  displayName: 'StackCardListItem'

  propTypes:
    card:  PropTypes.Card
    kind:  PropTypes.Kind
    stack: PropTypes.Stack

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.card.kind)
  }

  isReady: ->
    @state.kind?

  render: ->

    # TODO: The active class should really be on the link
    classes = classSet [
      'stack-card'
      'active' if @getScreen('workspace').isPanelVisible(@props.card.id)
    ]

    ListItem {@isReady, className: classes, 'data-itemid': @props.card.id},
      Link {onClick: @showCard},
        StackCard {stack: @props.stack, card: @props.card, kind: @state.kind}

  showCard: ->
    @getScreen('workspace').addPanelAfter(@props.stack.id, new CardPanelState(@props.card.id))

}

module.exports = StackCardListItem
