React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
{div, em, label} = React.DOM

CommandArgument = React.createClass {

  displayName: 'CommandArgument'

  propTypes:
    hint:  PropTypes.string
    label: PropTypes.string

  render: ->
    
    div {className: 'argument'}, [
      label {key: 'label'}, [
        @props.label
        em {}, @props.hint if @props.hint?
      ]
    ].concat(@props.children)

}

module.exports = CommandArgument
