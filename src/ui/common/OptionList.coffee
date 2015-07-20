#--------------------------------------------------------------------------------
_                   = require 'lodash'
mergeProps          = require 'common/util/mergeProps'
React               = require 'react/addons'
KeyCode             = require 'ui/framework/KeyCode'
PropTypes           = require 'ui/framework/PropTypes'
OptionListSeparator = React.createFactory(require 'ui/common/OptionListSeparator')
{cloneWithProps}    = React.addons
{div}               = React.DOM
#--------------------------------------------------------------------------------

OptionList = React.createClass {

  displayName: 'OptionList'

  propTypes:
    onSelect: PropTypes.func

  getInitialState: ->
    {highlight: -1}

  render: ->

    props = mergeProps _.omit(@props, 'onSelect'), {
      className: 'option-list'
    }

    div props, @renderChildren()

  renderChildren: ->
    @values = []
    return React.Children.map @props.children, (option, index) =>
      return unless option?

      if option.props.value is undefined
        return cloneWithProps option, {key: option.key ? index}

      position = @values.length
      @values.push(option.props.value)

      cloneWithProps option, {
        key:           option.key ? index
        onMouseOver:   @highlight.bind(this, position)
        onMouseOut:    @highlight.bind(this, position)
        onMouseUp:     @select.bind(this, option.props.value)
        isHighlighted: (position == @state.highlight)
      }

  getValue: ->
    @values[@state.highlight]

  highlight: (position) ->
    @setState {highlight: position}

  highlightPrevious: ->
    return unless @state.highlight > 0
    @highlight(@state.highlight - 1)

  highlightNext: ->
    return unless @state.highlight < @values.length - 1
    @highlight(@state.highlight + 1)

  select: (value) ->
    @props.onSelect(value)

}

module.exports = OptionList
