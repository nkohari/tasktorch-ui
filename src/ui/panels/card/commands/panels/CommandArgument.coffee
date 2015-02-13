React            = require 'react'
{div, em, label} = React.DOM

CommandArgument = React.createClass {

  displayName: 'CommandArgument'

  render: ->
    
    div {className: 'argument'}, [
      label {key: 'label'}, [
        @props.label
        em {}, @props.hint if @props.hint?
      ]
    ].concat(@props.children)

}

module.exports = CommandArgument
