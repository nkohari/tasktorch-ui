React        = require 'react'
Flux         = require 'mixins/Flux'
{div, input} = React.DOM

SearchBox = React.createClass {

  displayName: 'SearchBox'

  mixins: [Flux()]

  getInitialState: ->
    {value: @props.value}

  render: ->
    div {className: 'search'}, [
      input {key: 'search-input', placeholder: 'Search', value: @state.value}
    ]

}

module.exports = SearchBox
