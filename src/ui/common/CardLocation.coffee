_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PropTypes    = require 'framework/PropTypes'
CardStatus   = require 'framework/enums/CardStatus'
Url          = require 'framework/Url'
Icon         = React.createFactory(require 'ui/common/Icon')
Link         = React.createFactory(require 'ui/common/Link')
StackName    = React.createFactory(require 'ui/common/StackName')
{div, span}  = React.DOM

CardLocation = React.createClass {

  displayName: 'CardLocation'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack
    link:  PropTypes.bool

  mixins: [Router.State]

  getDefaultProps: ->
    {link: false}

  render: ->

    if @props.card.status == CardStatus.Complete
      contents = @renderArchive()
    else if @props.card.status == CardStatus.Deleted
      contents = @renderTrash()
    else if @props.link
      contents = @renderStackLink()
    else
      contents = @renderStackName()

    div {className: 'location'}, contents

  renderArchive: ->
    span {},
      Icon {name: 'archive'}
      'Archive'

  renderTrash: ->
    span {},
      Icon {name: 'trash'}
      'Trash'

  renderStackName: ->
    span {},
      Icon      {name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {stack: @props.stack}

  renderStackLink: ->
    url = new Url(this)
    url.addStackBefore(@props.stack.id, @props.card.id)

    Link url.makeLinkProps(), 
      Icon      {name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {stack: @props.stack}

}

module.exports = CardLocation
