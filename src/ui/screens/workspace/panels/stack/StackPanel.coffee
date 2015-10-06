#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
mergeProps    = require 'common/util/mergeProps'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
Panel         = React.createFactory(require 'ui/common/Panel')
StackHeader   = React.createFactory(require 'ui/screens/workspace/panels/stack/StackHeader')
StackCardList = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCardList')
StackFooter   = React.createFactory(require 'ui/screens/workspace/panels/stack/StackFooter')
{div}         = React.DOM
#--------------------------------------------------------------------------------
require './StackPanel.styl'
#--------------------------------------------------------------------------------

StackPanel = React.createClass {

  displayName: 'StackPanel'

  propTypes:
    id: PropTypes.id

  mixins: [CachedState]

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.id)
    cards: cache('cardsByStack').get(@props.id)
  }

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      className: 'stack'
    }
    
    Panel props,
      StackHeader {panelid: @props.id, stack: @state.stack}
      div {className: 'content'},
        StackCardList {stack: @state.stack, cards: @state.cards}
      StackFooter {stack: @state.stack}

}

module.exports = StackPanel
