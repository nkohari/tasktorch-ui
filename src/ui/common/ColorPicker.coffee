_             = require 'lodash'
React         = require 'react'
classSet      = require 'common/util/classSet'
KindColor     = require 'data/enums/KindColor'
PropTypes     = require 'ui/framework/PropTypes'
Icon          = React.createFactory(require 'ui/common/Icon')
{div, li, ul} = React.DOM

ColorPicker = React.createClass {

  displayName: 'ColorPicker'

  propTypes:
    value:    PropTypes.enum(KindColor)
    onChange: PropTypes.func

  render: ->

    items = _.map _.keys(KindColor), (color, index) =>
      classes = classSet [
        'color-option'
        color.toLowerCase()
        'selected' if @props.value == color
      ]
      li {key: color, className: classes, onClick: @onColorSelected.bind(this, color)}

    div {className: 'color-picker'},
      div {className: 'selected-color-name'}, @getColorName(@props.value)
      ul {className: 'color-options'}, items

  onColorSelected: (color) ->
    @props.onChange(color)

  getColorName: (color) ->
    switch color
      when KindColor.DeepPurple then 'Deep Purple'
      when KindColor.DeepOrange then 'Deep Orange'
      when KindColor.LightBlue  then 'Light Blue'
      when KindColor.LightGreen then 'Light Green'
      else color

}

module.exports = ColorPicker
