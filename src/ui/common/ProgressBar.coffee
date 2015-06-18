_                = require 'lodash'
React            = require 'react/addons'
CardStatus       = require 'data/enums/CardStatus'
PropTypes        = require 'ui/framework/PropTypes'
{div}            = React.DOM
{cloneWithProps} = React.addons

ProgressBar = React.createClass {

  displayName: 'ProgressBar'

  propTypes:
    total: PropTypes.number

  render: ->

    segments = _.map @props.children, (child) =>
      cloneWithProps child, {total: @props.total} if child?

    div {className: 'progress-bar'},
      segments

}

module.exports = ProgressBar
