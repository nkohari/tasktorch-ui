#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
classSet      = require 'common/util/classSet'
KindColor     = require 'data/enums/KindColor'
KeyCode       = require 'ui/framework/KeyCode'
PropTypes     = require 'ui/framework/PropTypes'
Icon          = React.createFactory(require 'ui/common/Icon')
{div, li, ul} = React.DOM
#--------------------------------------------------------------------------------
require './ColorPicker.styl'
#--------------------------------------------------------------------------------

ColorPicker = React.createClass {

  displayName: 'ColorPicker'

  propTypes:
    value:    PropTypes.enum(KindColor)
    onChange: PropTypes.func

  componentWillMount: ->
    @values = _.keys(KindColor)

  render: ->

    items = _.map @values, (color, index) =>
      classes = classSet [
        'color-option'
        color.toLowerCase()
        'selected' if @props.value == color
      ]
      li {key: color, ref: "item#{index}", tabIndex: index, className: classes, @onKeyUp, onFocus: @props.onChange.bind(null, color)}

    div {className: 'color-picker'},
      div {className: 'selected-color-name'}, @getColorName(@props.value)
      ul {className: 'color-options'}, items

  onKeyUp: (event) ->

    if @props.value?
      currentIndex = @values.indexOf(@props.value)
    else
      currentIndex = -1

    if event.which == KeyCode.LEFT and currentIndex > 0
      @refs["item#{currentIndex - 1}"].getDOMNode().focus()

    if event.which == KeyCode.RIGHT and currentIndex < @values.length - 1
      @refs["item#{currentIndex + 1}"].getDOMNode().focus()

  getColorName: (color) ->
    switch color
      when KindColor.DeepPurple then 'Deep Purple'
      when KindColor.DeepOrange then 'Deep Orange'
      when KindColor.LightBlue  then 'Light Blue'
      when KindColor.LightGreen then 'Light Green'
      else color

}

module.exports = ColorPicker
