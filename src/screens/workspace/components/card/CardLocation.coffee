_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PropTypes    = require 'common/PropTypes'
CardStatus   = require 'framework/enums/CardStatus'
WorkspaceUrl = require 'framework/urls/WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
StackName    = React.createFactory(require 'common/StackName')
Link         = React.createFactory(Router.Link)
{li, span}   = React.DOM

CardLocation = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardLocation'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack

  mixins: [Router.State]

  # Rendering ---------------------------------------------------------------------

  render: ->

    if @props.card.status == CardStatus.Complete
      child = @renderArchive()
    else if @props.card.status == CardStatus.Deleted
      child = @renderTrash()
    else
      child = @renderStackLink()

    li {className: 'location'}, [child]

  renderArchive: ->
    span {key: 'status'}, [
      Icon {key: 'icon', name: 'archive'}
      'Archive'
    ]

  renderTrash: ->
    span {key: 'status'}, [
      Icon {key: 'icon', name: 'trash'}
      'Trash'
    ]

  renderStackLink: ->
    Link @makeStackLinkProps(), [
      Icon      {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {key: 'name', stack: @props.stack}
    ]

  # Utility -----------------------------------------------------------------------

  makeStackLinkProps: ->
    url = new WorkspaceUrl(this)
    url.addStackBefore(@props.stack.id, @props.card.id)
    return _.extend {key: 'link'}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = CardLocation
