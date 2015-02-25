React        = require 'react/addons'
classSet     = require 'common/util/classSet'
StackType    = require 'data/enums/StackType'
PanelKey     = require 'ui/framework/PanelKey'
CachedState  = require 'ui/framework/mixins/CachedState'
UrlAware     = require 'ui/framework/mixins/UrlAware'
Link         = React.createFactory(require 'ui/common/Link')
ListItem     = React.createFactory(require 'ui/common/ListItem')
QueueCard    = React.createFactory(require 'ui/panels/stack/cards/QueueCard')
InboxCard    = React.createFactory(require 'ui/panels/stack/cards/InboxCard')
DraftsCard   = React.createFactory(require 'ui/panels/stack/cards/DraftsCard')
BacklogCard  = React.createFactory(require 'ui/panels/stack/cards/BacklogCard')
{li}         = React.DOM

StackCardListItem = React.createClass {

  displayName: 'StackCardListItem'

  mixins: [CachedState, UrlAware]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.card.kind)
  }

  isReady: ->
    @state.kind?

  render: ->

    # TODO: The active class should really be on the link
    classes = classSet [
      'stack-card'
      'active' if @getCurrentUrl().isPanelActive(PanelKey.forCard(@props.card.id))
    ]

    ListItem {@isReady, className: classes, 'data-itemid': @props.card.id},
      Link {@getLinkUrl},
        @renderContents()

  renderContents: ->
    switch @props.stack.type
      when StackType.Queue
        return QueueCard {stack: @props.stack, card: @props.card, kind: @state.kind}
      when StackType.Inbox
        return InboxCard {stack: @props.stack, card: @props.card, kind: @state.kind}
      when StackType.Drafts
        return DraftsCard {stack: @props.stack, card: @props.card, kind: @state.kind}
      when StackType.Backlog
        return BacklogCard {stack: @props.stack, card: @props.card, kind: @state.kind}

  getLinkUrl: (currentUrl) ->
    cardPanelKey  = PanelKey.forCard(@props.card.id)
    stackPanelKey = PanelKey.forStack(@props.stack.id)
    currentUrl.addPanelAfter(cardPanelKey, stackPanelKey)

}

module.exports = StackCardListItem
