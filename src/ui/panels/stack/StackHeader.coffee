_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Pure      = require 'ui/framework/mixins/Pure'
StackName = React.createFactory(require 'ui/common/StackName')
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

StackHeader = React.createClass {

  displayName: 'StackHeader'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Pure]

  render: ->

    div {className: 'header'},
      Icon {name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {className: 'title', stack: @props.stack}

}

module.exports = StackHeader
