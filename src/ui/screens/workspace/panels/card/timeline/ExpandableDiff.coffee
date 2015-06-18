#--------------------------------------------------------------------------------
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Diff       = React.createFactory(require 'ui/common/Diff')
{a, span}  = React.DOM
#--------------------------------------------------------------------------------

ExpandableDiff = React.createClass {

  displayName: 'ExpandableDiff'

  propTypes:
    from: PropTypes.string
    to:   PropTypes.string

  getInitialState: ->
    {expanded: false}

  render: ->

    span {className: 'expandable-diff'},
      a {className: 'diff-toggle', onClick: @toggleExpanded},
        if @state.expanded then '(hide change)' else '(show change)'
      Diff {from: @props.from, to: @props.to} if @state.expanded

  toggleExpanded: ->
    @setState {expanded: !@state.expanded}

}

module.exports = ExpandableDiff
