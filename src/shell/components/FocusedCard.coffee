_                  = require 'lodash'
React              = require 'react'
ActiveUrl          = require 'mixins/ActiveUrl'
Observe            = require 'mixins/Observe'
LoadMyQueueRequest = require 'requests/LoadMyQueueRequest'
WorkspaceUrl       = require '../../screens/workspace/WorkspaceUrl'
Icon               = React.createFactory(require 'common/Icon')
Hotlink            = React.createFactory(require 'common/Hotlink')
{div, span}        = React.DOM

FocusedCard = React.createClass {

  displayName: 'FocusedCard'

  mixins: [
    Observe('queue')
    ActiveUrl(WorkspaceUrl)
  ]

  getStateFromStores: (stores) ->
    return {
      focusedCard: stores.queue.getFocusedCard()
    }

  componentWillMount: ->
    @execute new LoadMyQueueRequest()

  render: ->

    # TODO: Proper loading indicator
    unless @state.focusedCard?
      return div {}, ["Loading"]

    linkProps = _.extend {key: 'link', hotkey: 'f'}, @makeLinkProps()
    div {className: 'focused-card'}, [
      Hotlink linkProps, [@state.focusedCard.title]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addCard(@state.focusedCard.id)
    return url.makeLinkProps()

}

module.exports = FocusedCard
