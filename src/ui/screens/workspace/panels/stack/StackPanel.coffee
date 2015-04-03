_               = require 'lodash'
React           = require 'react'
mergeProps      = require 'common/util/mergeProps'
PropTypes       = require 'ui/framework/PropTypes'
Actor           = require 'ui/framework/mixins/Actor'
CachedState     = require 'ui/framework/mixins/CachedState'
Navigator       = require 'ui/framework/mixins/Navigator'
StackPanelState = require 'ui/screens/workspace/panels/stack/StackPanelState'
Frame           = React.createFactory(require 'ui/common/Frame')
StackHeader     = React.createFactory(require 'ui/screens/workspace/panels/stack/StackHeader')
StackCardList   = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCardList')
StackFooter     = React.createFactory(require 'ui/screens/workspace/panels/stack/StackFooter')

StackPanel = React.createClass {

  displayName: 'StackPanel'

  propTypes:
    id: PropTypes.id

  mixins: [Actor, CachedState, Navigator]

  listensFor: ['StackDeleted']

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.id)
  }

  isReady: ->
    @state.stack?

  render: ->

    props = mergeProps _.omit(@props, 'id'), {
      className: 'stack panel'
      @isReady
    }
    
    Frame props,
      StackHeader   {panelid: @props.id, stack: @state.stack}
      StackCardList {stack: @state.stack}
      StackFooter   {stack: @state.stack}

  onStackDeleted: (event) ->
    if event.stack.id == @props.id
      @getScreen('workspace').removePanel(new StackPanelState(event.stack.id))

}

module.exports = StackPanel
