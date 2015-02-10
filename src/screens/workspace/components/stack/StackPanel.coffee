_                       = require 'lodash'
React                   = require 'react'
Router                  = require 'react-router'
PropTypes               = require 'common/PropTypes'
mergeProps              = require 'common/util/mergeProps'
Observe                 = require 'mixins/Observe'
StackDisplayedEvent     = require 'events/display/StackDisplayedEvent'
WorkspaceUrl            = require 'framework/urls/WorkspaceUrl'
Frame                   = React.createFactory(require 'common/Frame')
Icon                    = React.createFactory(require 'common/Icon')
StackHeader             = React.createFactory(require './StackHeader')
StackCardList           = React.createFactory(require './StackCardList')
StackFooter             = React.createFactory(require './StackFooter')
Link                    = React.createFactory(Router.Link)
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

  componentWillMount: ->
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
    url = new WorkspaceUrl(this)
    url.removeStack(@props.stackid)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = StackPanel
