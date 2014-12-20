_         = require 'lodash'
React     = require 'react'
PropTypes = require 'common/PropTypes'
StackName = React.createFactory(require 'common/StackName')
Icon      = React.createFactory(require 'common/Icon')
{div}     = React.DOM

StackHeader = React.createClass {

  #--------------------------------------------------------------------------------

  displayName: 'StackHeader'

  propTypes:
    stack: PropTypes.Stack

  #--------------------------------------------------------------------------------

  render: ->
    div {className: 'header'}, [
      Icon {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
      StackName {key: 'title', className: 'title', stack: @props.stack}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = StackHeader
