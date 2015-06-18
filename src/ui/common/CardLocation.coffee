#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
Router          = require 'react-router'
mergeClasses    = require 'common/util/mergeClasses'
PropTypes       = require 'ui/framework/PropTypes'
Navigator       = require 'ui/framework/mixins/Navigator'
CardStatus      = require 'data/enums/CardStatus'
Icon            = React.createFactory(require 'ui/common/Icon')
Link            = React.createFactory(require 'ui/common/Link')
StackName       = React.createFactory(require 'ui/common/StackName')
StackPanelState = require 'ui/screens/workspace/panels/stack/StackPanelState'
{div, span}     = React.DOM
#--------------------------------------------------------------------------------

CardLocation = React.createClass {

  displayName: 'CardLocation'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack
    link:  PropTypes.bool

  mixins: [Navigator]

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

    classes = mergeClasses('location', @props.className)
    div {className: classes}, contents

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
      Icon      {name: @props.stack?.type.toLowerCase()}
      StackName {stack: @props.stack}

  renderStackLink: ->
    Link {onClick: @showStack},
      Icon      {name: @props.stack?.type.toLowerCase()}
      StackName {stack: @props.stack}

  showStack: ->
    @getScreen('workspace').addPanelBefore(@props.card.id, new StackPanelState(@props.stack.id))

}

module.exports = CardLocation
