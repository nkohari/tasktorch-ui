_              = require 'lodash'
React          = require 'react'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Frame          = React.createFactory(require 'ui/common/Frame')
StackCloseLink = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCloseLink')
StackHeader    = React.createFactory(require 'ui/screens/workspace/panels/stack/StackHeader')
StackCardList  = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCardList')
StackFooter    = React.createFactory(require 'ui/screens/workspace/panels/stack/StackFooter')

StackPanel = React.createClass {

  displayName: 'StackPanel'

  propTypes:
    stackid: PropTypes.id

  mixins: [CachedState]

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.stackid)
  }

  isReady: ->
    @state.stack?

  render: ->

    props = mergeProps @props, {
      className: 'stack panel'
      @isReady
    }
    
    Frame props,
      StackCloseLink {stack: @state.stack}
      StackHeader    {stack: @state.stack}
      StackCardList  {stack: @state.stack}
      StackFooter    {stack: @state.stack}

}

module.exports = StackPanel
