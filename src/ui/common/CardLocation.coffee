#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
Router               = require 'react-router'
mergeClasses         = require 'common/util/mergeClasses'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CardStatus           = require 'data/enums/CardStatus'
Icon                 = React.createFactory(require 'ui/common/Icon')
Link                 = React.createFactory(require 'ui/common/Link')
StackName            = React.createFactory(require 'ui/common/StackName')
StackPanelSpec       = require 'ui/framework/panels/StackPanelSpec'
{div, span}          = React.DOM
#--------------------------------------------------------------------------------

CardLocation = React.createClass {

  displayName: 'CardLocation'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack
    link:  PropTypes.bool

  mixins: [Actor]

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
    @publish new UserOpenedPanelEvent(new StackPanelSpec(@props.stack.id), {before: @props.card.id})

}

module.exports = CardLocation
