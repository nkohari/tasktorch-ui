_                             = require 'lodash'
React                         = require 'react/addons'
classSet                      = require 'framework/util/classSet'
Observe                       = require 'framework/mixins/Observe'
LoadSuggestionsRequest        = require 'requests/LoadSuggestionsRequest'
Caret                         = React.createFactory(require 'ui/common/Caret')
Icon                          = React.createFactory(require 'ui/common/Icon')
{a, div, ul, li, span, input} = React.DOM

SuggestingSelector = React.createClass {

  displayName: 'SuggestingSelector'

  mixins: [Observe('suggestions')]

  getInitialState: -> {
    expanded:      false
    phrase:        undefined
    selectionType: @props.selectionType
    selection:     @props.selection
  }

  componentDidMount: ->
    @types = _.flatten [@props.suggest]

  componentWillReceiveProps: (newProps) ->
    if newProps.selection?
      @setState {selectionType: newProps.selectionType, selection: newProps.selection}

  sync: (stores) ->
    suggestions = stores.suggestions.get(@types, @state.phrase) if @state?.phrase?
    {suggestions}

  render: ->

    classes = classSet [
      'selector'
      'expanded' if @state.expanded
    ]

    div {className: classes},
      @renderTrigger()
      @renderDropDown() if @state.expanded

  renderTrigger: ->

    if @state.selection?
      value = @props.option {type: @state.selectionType, value: @state.selection}
    else
      value = span {className: 'placeholder'}, [@props.placeholder ? 'Click to select']

    a {className: 'trigger', onClick: @onTriggerClicked},
      div {className: 'value'}, value
      Caret {flip: @state.expanded}

  renderDropDown: ->

    if @state.suggestions?
      options = ul {className: 'options'}, _.map(@types, @renderOptionGroup)

    div {className: 'drop'},
      div {className: 'suggest'},
        input {ref: 'input', type: 'text', value: @state.phrase, onChange: @onInputChanged}
        Icon {name: 'search'}
      options

  renderOptionGroup: (type) ->

    console.log "rendering option group for #{type}"

    suggestions = @state.suggestions?[type]
    return [] unless suggestions?

    _.map suggestions, (item) =>
      li {
        key:       "option-#{item.id}"
        className: classSet {option: true, selected: @state.selection?.id == item.id}
        onClick:   @onOptionSelected.bind(this, item, type)
      }, @props.option {type: type, value: item}

  onTriggerClicked: (event) ->
    @setState {expanded: !@state.expanded}, =>
      if @state.expanded
        node = @refs.input.getDOMNode()
        node.focus()
        node.select()

  onInputChanged: (event) ->
    phrase = event.target.value
    @setState {phrase}, =>
      @execute new LoadSuggestionsRequest(@types, phrase) if phrase.length > 0

  onOptionSelected: (item, type) ->
    @setState {expanded: false, selectionType: type, selection: item}
    @props.onChange(item, type) if @props.onChange?

}

module.exports = SuggestingSelector
