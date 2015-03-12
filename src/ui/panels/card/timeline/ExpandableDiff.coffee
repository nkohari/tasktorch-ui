React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Diff       = React.createFactory(require 'ui/common/Diff')
{a, span}  = React.DOM

ActivityDiff = React.createClass {

  displayName: 'ActivityDiff'

  propTypes:
    from: PropTypes.string
    to:   PropTypes.string

  getInitialState: ->
    {expanded: false}

  render: ->

    span {className: 'activity-diff'},
      a {className: 'diff-toggle', onClick: @toggleExpanded},
        if @state.expanded then '(hide change)' else '(show change)'
      Diff {from: @props.from, to: @props.to} if @state.expanded

  toggleExpanded: ->
    @setState {expanded: !@state.expanded}

}

module.exports = ActivityDiff
