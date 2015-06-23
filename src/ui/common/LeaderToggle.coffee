#--------------------------------------------------------------------------------
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{span}    = React.DOM
#--------------------------------------------------------------------------------
require './LeaderToggle.styl'
#--------------------------------------------------------------------------------

LeaderToggle = React.createClass {

  displayName: 'LeaderToggle'

  propTypes:
    value:    PropTypes.bool
    onChange: PropTypes.func

  render: ->

    classes = classSet [
      'leader-toggle'
      'trigger'
      'active' if @props.value
    ]

    if @props.value
      span {className: classes, @onClick},
        Icon {name: 'secure'}
        'Leader'
    else
      span {className: classes, @onClick},
        'Member'

  onClick: ->
    @props.onChange(!@props.value)

}

module.exports = LeaderToggle
