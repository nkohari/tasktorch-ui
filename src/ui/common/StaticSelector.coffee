#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react/addons'
classSet      = require 'common/util/classSet'
dom           = require 'common/util/dom'
PropTypes     = require 'ui/framework/PropTypes'
KeyCode       = require 'ui/framework/KeyCode'
Caret         = React.createFactory(require 'ui/common/Caret')
Icon          = React.createFactory(require 'ui/common/Icon')
Input         = React.createFactory(require 'ui/common/Input')
{div, li, ul} = React.DOM
#--------------------------------------------------------------------------------
require './StaticSelector.styl'
#--------------------------------------------------------------------------------

StaticSelector = React.createClass {

  displayName: 'StaticSelector'

  props:
    value:        PropTypes.any
    options:      PropTypes.arrayOf(PropTypes.any)
    component:    PropTypes.func
    onChange:     PropTypes.func
    placeholder:  PropTypes.string

  getDefaultProps: ->
    {placeholder: 'Click to select'}

  getInitialState: ->
    {expanded: false, highlightIndex: -1}

  componentDidMount: ->
    document.addEventListener('click', @onClickOutside)
    @refs.trigger.getDOMNode().focus()

  componentDidUnmount: ->
    document.removeEventListener('click', @onClickOutside)

  render: ->

    if @state.expanded
      options = _.map @props.options, (value, index) =>
        classes = classSet [
          'selector-option'
          'highlighted' if @state.highlightIndex == index
        ]
        li {key: index, className: classes, onMouseOver: @highlight.bind(this, value), onMouseUp: @select.bind(this, value)},
          @props.component {value}
      drop = ul {className: 'selector-options'}, options

    if @props.value?
      value = div {className: 'selector-value'},
        @props.component {value: @props.value}
    else
      value = div {className: 'selector-value placeholder'},
        @props.placeholder

    classes = classSet [
      'static-selector'
      'expanded' if @state.expanded
    ]

    div {className: classes},
      div {ref: 'trigger', tabIndex: 1, className: 'selector-trigger', @onKeyDown, onMouseDown: @toggle},
        value
        Caret {}
      drop

  expand: ->
    @setState {expanded: true}

  collapse: ->
    @setState {expanded: false}

  toggle: ->
    @setState {expanded: !@state.expanded}

  highlight: (value) ->
    @setState {highlightIndex: _.indexOf(@props.options, value)}

  select: (value) ->
    @setState {expanded: false, highlightIndex: -1}
    @props.onChange(value)

  onClickOutside: (event) ->
    return unless @isMounted()
    @collapse() unless dom.hasAncestor(event.target, @getDOMNode())

  onKeyDown: (event) ->
    event.preventDefault()
    event.stopPropagation()
    if not @state.expanded
      @setState {expanded: true}
    else if event.which == KeyCode.RETURN and @state.highlightIndex != -1
      @select(@props.options[@state.highlightIndex])
    else if event.which == KeyCode.UP and @state.highlightIndex > 0
      @setState {highlightIndex: @state.highlightIndex - 1}
    else if event.which == KeyCode.DOWN and @state.highlightIndex < @props.options?.length - 1
      @setState {highlightIndex: @state.highlightIndex + 1}

}

module.exports = StaticSelector