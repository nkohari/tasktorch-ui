_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
StackName = React.createFactory(require 'ui/common/StackName')
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

StackHeader = React.createClass {

  displayName: 'StackHeader'

  propTypes:
    stack: PropTypes.Stack

  render: ->

    div {className: 'header'},
      Icon {name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {className: 'title', stack: @props.stack}

}

module.exports = StackHeader
