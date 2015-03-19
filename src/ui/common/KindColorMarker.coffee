React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{span}    = React.DOM

KindColorMarker = React.createClass {

  displayName: 'KindColorMarker'

  propTypes:
    kind: PropTypes.Kind

  render: ->

    if @props.kind?
      style = {backgroundColor: @props.kind.color}

    span {
      className: 'kind-color-marker'
      style
    }

}

module.exports = KindColorMarker
