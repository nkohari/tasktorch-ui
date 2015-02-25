_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
classSet  = require 'common/util/classSet'
{span}    = React.DOM

Caret = React.createClass {

  displayName: 'Caret'

  propTypes:
    flip: PropTypes.bool

  render: ->

    classes = classSet [
      'caret'
      'flip' if @props.flip
    ]

    span {className: classes}

}

module.exports = Caret
