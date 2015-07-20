#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
classSet    = require 'common/util/classSet'
mergeProps  = require 'common/util/mergeProps'
PropTypes   = require 'ui/framework/PropTypes'
Icon        = React.createFactory(require 'ui/common/Icon')
{div, span} = React.DOM
#--------------------------------------------------------------------------------
require './TeamOption.styl'
#--------------------------------------------------------------------------------

TeamOption = React.createClass {

  displayName: 'TeamOption'

  propTypes:
    value:         PropTypes.User
    isHighlighted: PropTypes.bool

  render: ->

    props = mergeProps _.omit(@props, 'value', 'isHighlighted'), {
      className: classSet [
        'team-option'
        'highlighted' if @props.isHighlighted
      ]
    }

    div props,
      Icon {name: 'team'}
      span {className: 'text'}, @props.value.name

}

module.exports = TeamOption
