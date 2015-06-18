#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
classSet         = require 'common/util/classSet'
Caret            = React.createFactory(require 'ui/common/Caret')
Icon             = React.createFactory(require 'ui/common/Icon')
{a, div, ul, li} = React.DOM
#--------------------------------------------------------------------------------
require './Selector.styl'
#--------------------------------------------------------------------------------

Selector = React.createClass {

  displayName: 'Selector'

  getInitialState: ->
    {expanded: false, selection: @props.selection}

  render: ->

    classes = classSet [
      'selector'
      'expanded' if @state.expanded
    ]

    div {className: classes},
      a {className: 'trigger', onClick: @onTriggerClicked},
        div {className: 'value'}, @getSelectedOption()
        Caret {}
      @renderDropDown() if @state.expanded

  renderDropDown: ->

    options = _.map @props.children, (child) =>
      li {
        key:       "option-#{child.props.value}"
        className: classSet {option: true, selected: @state.selection == child.props.value}
        onClick:   @onOptionSelected.bind(this, child.props.value)
      }, child

    div {className: 'drop'},
      ul {className: 'options'}, options

  getSelectedOption: ->
    _.find @props.children, (child) =>
      child.props.value == @state.selection

  onTriggerClicked: ->
    @setState {expanded: !@state.expanded}

  onOptionSelected: (value) ->
    @setState {expanded: false, selection: value}
    @props.onChange(value) if @props.onChange?

}

module.exports = Selector
