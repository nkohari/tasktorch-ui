React        = require 'react'
Observe      = require 'mixins/Observe'
{div, input} = React.DOM

SearchBox = React.createClass {

  displayName: 'SearchBox'

  mixins: [Observe()]

  getInitialState: ->
    {value: @props.value}

  render: ->
    div {className: 'search'}, [
      input {key: 'search-input', placeholder: 'Search', value: @state.value}
    ]

}

module.exports = SearchBox
