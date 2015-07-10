#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
mergeProps      = require 'common/util/mergeProps'
PropTypes       = require 'ui/framework/PropTypes'
Actor           = require 'ui/framework/mixins/Actor'
CachedState     = require 'ui/framework/mixins/CachedState'
Navigator       = require 'ui/framework/mixins/Navigator'
StackPanelState = require 'ui/screens/workspace/panels/stack/StackPanelState'
Panel           = React.createFactory(require 'ui/common/Panel')
StackHeader     = React.createFactory(require 'ui/screens/workspace/panels/stack/StackHeader')
StackCardList   = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCardList')
StackFooter     = React.createFactory(require 'ui/screens/workspace/panels/stack/StackFooter')
{div}           = React.DOM
#--------------------------------------------------------------------------------
require './StackPanel.styl'
#--------------------------------------------------------------------------------

StackPanel = React.createClass {

  displayName: 'StackPanel'

  propTypes:
    id: PropTypes.id

  mixins: [Actor, CachedState, Navigator]

  listensFor: ['StackDeleted']

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.id)
    cards: cache('cardsByStack').get(@props.id)
  }

  render: ->

    props = mergeProps _.omit(@props, 'id'), {
      className: 'stack'
    }
    
    Panel props,
      StackHeader {panelid: @props.id, stack: @state.stack}
      div {className: 'content'},
        StackCardList {stack: @state.stack, cards: @state.cards}
      StackFooter {stack: @state.stack}

  onStackDeleted: (event) ->
    if event.stack.id == @props.id
      @getScreen('workspace').removePanel(new StackPanelState(event.stack.id))

}

module.exports = StackPanel
