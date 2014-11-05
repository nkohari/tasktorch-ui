_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
ActiveUrl    = require '../../mixins/ActiveUrl'
WorkspaceUrl = require '../../workspace/WorkspaceUrl'
Icon         = React.createFactory(require '../../common/Icon')
Link         = React.createFactory(Router.Link)
{div, span}  = React.DOM

FocusedCard = React.createClass {

  displayName: 'FocusedCard'

  mixins: [
    ActiveUrl(WorkspaceUrl)
  ]

  render: ->
    linkProps = _.extend {className: 'focused-card'}, @makeLinkProps()
    Link linkProps, [
      div {name: 'title', className: 'title'}, [@props.focusedCard.title]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addCard(@props.focusedCard.id)
    return url.makeLinkProps()

}

module.exports = FocusedCard
