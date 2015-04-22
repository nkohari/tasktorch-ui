_            = require 'lodash'
React        = require 'react'
classSet     = require 'common/util/classSet'
mergeClasses = require 'common/util/mergeClasses'
PropTypes    = require 'ui/framework/PropTypes'
{li}         = React.DOM

SelectorOption = React.createClass {

  displayName: 'SelectorOption'

  props:
    value:           PropTypes.object
    isHighlighted:   PropTypes.bool
    highlightOption: PropTypes.func
    selectOption:    PropTypes.func

  render: ->

    classes = classSet [
      'selector-option'
      'highlighted' if @props.isHighlighted
    ]

    li {className: mergeClasses(classes, @props.className), @onMouseOver, @onClick},
      @props.children

  onMouseOver: (event) ->
    @props.highlightOption(@props.value)

  onClick: (event) ->
    @props.selectOption(@props.value)

}

module.exports = SelectorOption
