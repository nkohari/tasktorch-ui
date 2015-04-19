React        = require 'react'
mergeClasses = require 'common/util/mergeClasses'
PropTypes    = require 'ui/framework/PropTypes'
{div}        = React.DOM

CardCommandOverlay = React.createClass {

  displayName: 'CardCommandOverlay'

  props:
    buttons: PropTypes.node

  render: ->

    classes = mergeClasses('command-overlay', @props.className)

    div {className: classes},
      div {className: 'content'},
        @props.children
      @props.buttons

}

module.exports = CardCommandOverlay
