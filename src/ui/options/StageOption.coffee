#--------------------------------------------------------------------------------
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Icon        = React.createFactory(require 'ui/common/Icon')
{div, span} = React.DOM
#--------------------------------------------------------------------------------
require './StageOption.styl'
#--------------------------------------------------------------------------------

StageOption = React.createClass {

  displayName: 'StageOption'

  propTypes:
    value: PropTypes.Stage

  render: ->

    div {className: 'stage-option'},
      Icon {name: 'checklist'}
      span {className: 'text'}, @props.value.name

}

module.exports = StageOption
