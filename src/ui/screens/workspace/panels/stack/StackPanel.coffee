_              = require 'lodash'
React          = require 'react'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Frame          = React.createFactory(require 'ui/common/Frame')
PanelCloseLink = React.createFactory(require 'ui/common/PanelCloseLink')
StackHeader    = React.createFactory(require 'ui/screens/workspace/panels/stack/StackHeader')
StackCardList  = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCardList')
StackFooter    = React.createFactory(require 'ui/screens/workspace/panels/stack/StackFooter')

StackPanel = React.createClass {

  displayName: 'StackPanel'

  propTypes:
    id: PropTypes.id

  mixins: [CachedState]

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
      PanelCloseLink {id: @props.id}
      StackHeader    {stack: @state.stack}
      StackCardList  {stack: @state.stack}
      StackFooter    {stack: @state.stack}

}

module.exports = StackPanel
