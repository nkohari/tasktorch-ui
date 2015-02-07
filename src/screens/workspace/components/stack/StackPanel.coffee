_                       = require 'lodash'
React                   = require 'react'
Router                  = require 'react-router'
PropTypes               = require 'common/PropTypes'
mergeProps              = require 'common/util/mergeProps'
ActiveUrl               = require 'mixins/ActiveUrl'
Observe                 = require 'mixins/Observe'
StackDisplayedEvent     = require 'events/display/StackDisplayedEvent'
WorkspaceUrl            = require '../../WorkspaceUrl'
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
    ActiveUrl(WorkspaceUrl)
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

  ready: ->
    {stack: @state.stack?}

  # Rendering ---------------------------------------------------------------------

  render: ->
    props = mergeProps @props, {
      className: 'stack panel'
    }
    div props, @contents()

  children: ->
    return [
      @makeCloseLink()
      StackHeader   {key: 'header', stack: @state.stack}
      StackCardList {key: 'cards',  stack: @state.stack}
      StackFooter   {key: 'footer', stack: @state.stack}
    ]

  # Utility -----------------------------------------------------------------------

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeStack(@props.stackid)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = StackPanel
