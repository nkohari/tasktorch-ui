_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PropTypes    = require 'framework/PropTypes'
CardStatus   = require 'framework/enums/CardStatus'
Url          = require 'framework/Url'
Icon         = React.createFactory(require 'ui/common/Icon')
Link         = React.createFactory(require 'ui/common/Link')
StackName    = React.createFactory(require 'ui/common/StackName')
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
    url = new Url(this)
    url.addStackBefore(@props.stack.id, @props.card.id)
    return _.extend {key: 'link'}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = CardLocation
