_     = require 'lodash'
React = require 'react'
{ul}  = React.DOM

List = React.createClass {

  displayName: 'List'

  render: ->
    Component = @props.component
    items = _.map @props.items, (item) =>
      props = {key: "#{@props.kind}-#{item.id}"}
      props[@props.kind] = item
      Component(props)
    props = _.omit(@props, 'component', 'items', 'kind')
    ul props, items

}

module.exports = List
