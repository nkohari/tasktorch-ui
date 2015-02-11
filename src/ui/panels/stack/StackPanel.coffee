_                       = require 'lodash'
React                   = require 'react'
Router                  = require 'react-router'
PropTypes               = require 'framework/PropTypes'
mergeProps              = require 'framework/util/mergeProps'
Observe                 = require 'framework/mixins/Observe'
StackDisplayedEvent     = require 'events/display/StackDisplayedEvent'
Url                     = require 'framework/Url'
Frame                   = React.createFactory(require 'ui/common/Frame')
Icon                    = React.createFactory(require 'ui/common/Icon')
Link                    = React.createFactory(require 'ui/common/Link')
StackHeader             = React.createFactory(require 'ui/panels/stack/StackHeader')
StackCardList           = React.createFactory(require 'ui/panels/stack/StackCardList')
StackFooter             = React.createFactory(require 'ui/panels/stack/StackFooter')
{div}                   = React.DOM

StackPanel = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'StackPanel'

  propTypes:
    stackid:  PropTypes.id.isRequired
    position: PropTypes.number.isRequired

  mixins: [
    Observe('cards', 'stacks')
    Router.State
  ]

  # Lifecycle ---------------------------------------------------------------------

  componentDidMount: ->
    @publish new StackDisplayedEvent(@props.stackid)

  componentWillReceiveProps: (newProps) ->
    if newProps.stackid != @props.stackid
      @publish new StackDisplayedEvent(@props.stackid)

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    {stack: stores.stacks.get(@props.stackid)}

  isReady: ->
    @state.stack?

  # Rendering ---------------------------------------------------------------------

  render: ->

    props = mergeProps @props, {
      @isReady
      className: 'stack panel'
    }
    
    Frame props, [
      @makeCloseLink()
      StackHeader   {key: 'header', stack: @state.stack}
      StackCardList {key: 'cards',  stack: @state.stack}
      StackFooter   {key: 'footer', stack: @state.stack}
    ]

  # Utility -----------------------------------------------------------------------

  makeCloseLink: ->
    url = new Url(this)
    url.removeStack(@props.stackid)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = StackPanel
