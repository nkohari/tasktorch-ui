_            = require 'lodash'
React        = require 'react'
classSet     = require 'util/classSet'
{a, div, ul, li} = React.DOM

Selector = React.createClass {

  displayName: 'Selector'

  getInitialState: ->
    {expanded: false, selection: @props.selection}

  render: ->

    div {
      className: classSet {selector: true, expanded: @state.expanded}
    }, [
      a {className: 'trigger', onClick: @onTriggerClicked}, [@getSelectedOption()]
      @renderDropDown() if @state.expanded
    ]

  renderDropDown: ->

    options = _.map @props.children, (child) =>
      li {
        key:       "option-#{child.props.value}"
        className: classSet {option: true, selected: @state.selection == child.props.value}
        onClick:   @onOptionSelected.bind(this, child.props.value)
      }, child

    div {key: 'drop', className: 'drop'}, [
      ul {key: 'options', className: 'options'}, options
    ]

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
