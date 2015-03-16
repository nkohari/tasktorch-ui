React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{span}    = React.DOM

KindColorMarker = React.createClass {

  displayName: 'KindColorMarker'

  propTypes:
    kind: PropTypes.Kind

  render: ->

    span {
      className: 'kind-color-marker'
      style: {backgroundColor: @props.kind.color}
    }

}

module.exports = KindColorMarker
