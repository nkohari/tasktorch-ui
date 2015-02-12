_                   = require 'lodash'
React               = require 'react'
Router              = require 'react-router'
PropTypes           = require 'framework/PropTypes'
mergeProps          = require 'framework/util/mergeProps'
Observe             = require 'framework/mixins/Observe'
StackDisplayedEvent = require 'events/display/StackDisplayedEvent'
Url                 = require 'framework/Url'
Frame               = React.createFactory(require 'ui/common/Frame')
Icon                = React.createFactory(require 'ui/common/Icon')
Link                = React.createFactory(require 'ui/common/Link')
StackCloseLink      = React.createFactory(require 'ui/panels/stack/StackCloseLink')
StackHeader         = React.createFactory(require 'ui/panels/stack/StackHeader')
StackCardList       = React.createFactory(require 'ui/panels/stack/StackCardList')
StackFooter         = React.createFactory(require 'ui/panels/stack/StackFooter')

StackPanel = React.createClass {

  displayName: 'StackPanel'

  propTypes:
    stackid: PropTypes.id.isRequired

  mixins: [Observe('cards', 'stacks')]

  componentDidMount: ->
    @publish new StackDisplayedEvent(@props.stackid)

  componentWillReceiveProps: (newProps) ->
    @publish new StackDisplayedEvent(@props.stackid) if newProps.stackid != @props.stackid

  sync: (stores) ->
    {stack: stores.stacks.get(@props.stackid)}

  isReady: ->
    @state.stack?

  render: ->

    props = mergeProps @props, {
      @isReady
      className: 'stack panel'
    }
    
    Frame props,
      StackCloseLink {stack: @state.stack}
      StackHeader    {stack: @state.stack}
      StackCardList  {stack: @state.stack}
      StackFooter    {stack: @state.stack}

}

module.exports = StackPanel
