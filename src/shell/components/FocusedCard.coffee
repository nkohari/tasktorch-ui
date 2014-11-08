_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
ActiveUrl    = require 'mixins/ActiveUrl'
Flux         = require 'mixins/Flux'
WorkspaceUrl = require '../../screens/workspace/WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Link         = React.createFactory(Router.Link)
{div, span}  = React.DOM

FocusedCard = React.createClass {

  displayName: 'FocusedCard'

  mixins: [
    Flux('queue')
    ActiveUrl(WorkspaceUrl)
  ]

  getStateFromStores: (stores) ->
    return {
      focusedCard: stores.queue.getFocusedCard()
    }

  componentWillMount: ->
    @getController().loadMyQueue()

  render: ->

    # TODO: Proper loading indicator
    unless @state.focusedCard?
      return div {}, ["Loading"]

    linkProps = _.extend {className: 'focused-card'}, @makeLinkProps()
    Link linkProps, [
      div {key: 'title', className: 'title'}, [@state.focusedCard.title]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addCard(@state.focusedCard.id)
    return url.makeLinkProps()

}

module.exports = FocusedCard
