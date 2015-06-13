_                = require 'lodash'
React            = require 'react'
CardStatus       = require 'data/enums/CardStatus'
PropTypes        = require 'ui/framework/PropTypes'
{div}            = React.DOM
{cloneWithProps} = React.addons

ProgressBar = React.createClass {

  displayName: 'ProgressBar'

  render: ->

    total = _.sum @props.children, (child) -> child.props.value

    segments = _.map @props.children, (child) ->
      cloneWithProps child, {total}

    div {className: 'progress-bar'},
      segments

}

module.exports = ProgressBar
