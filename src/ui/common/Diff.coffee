#--------------------------------------------------------------------------------
_           = require 'lodash'
diff        = require 'diff'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
{div, span} = React.DOM
#--------------------------------------------------------------------------------

Diff = React.createClass {

  displayName: 'Diff'

  propTypes:
    from: PropTypes.string
    to:   PropTypes.string

  componentWillMount: ->
    @chunks = diff.diffWords(@props.from, @props.to)

  componentWillReceiveProps: (newProps) ->
    if @props.from != newProps.from or @props.to != newProps.to
      @chunks = diff.diffWords(newProps.from, newProps.to)

  render: ->

    chunks = _.map @chunks, (chunk) ->
      if chunk.added
        className = 'chunk added'
      else if chunk.removed
        className = 'chunk removed'
      else
        className = 'chunk'
      span {className}, chunk.value

    div {className: 'diff'}, chunks

}

module.exports = Diff
