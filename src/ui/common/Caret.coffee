_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
classSet  = require 'framework/util/classSet'
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
