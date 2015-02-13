React        = require 'react'
{div, input} = React.DOM

SearchBox = React.createClass {

  displayName: 'SearchBox'

  getInitialState: ->
    {value: @props.value}

  render: ->

    div {className: 'search'},
      input {placeholder: 'Search', value: @state.value}

}

module.exports = SearchBox
