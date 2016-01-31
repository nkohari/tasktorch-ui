#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
CardStatus       = require 'data/enums/CardStatus'
PropTypes        = require 'ui/framework/PropTypes'
{div}            = React.DOM
{cloneWithProps} = React.addons
#--------------------------------------------------------------------------------
require './ProgressBar.styl'
#--------------------------------------------------------------------------------

ProgressBar = React.createClass {

  displayName: 'ProgressBar'

  propTypes:
    total: PropTypes.number

  getDefaultProps: ->
    {total: 100}

  render: ->

    segments = React.Children.map @props.children, (child) =>
      cloneWithProps child, {total: @props.total} if child?

    div {className: 'progress-bar'},
      segments

}

module.exports = ProgressBar
