_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PanelKey     = require 'ui/framework/PanelKey'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
CardStatus   = require 'data/enums/CardStatus'
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
    Link {@getLinkUrl},
      Icon      {name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {stack: @props.stack}

  getLinkUrl: (currentUrl) ->
    stackPanelKey = PanelKey.forStack(@props.stack.id)
    cardPanelKey  = PanelKey.forCard(@props.card.id)
    currentUrl.addPanelBefore(stackPanelKey, cardPanelKey)

}

module.exports = CardLocation
