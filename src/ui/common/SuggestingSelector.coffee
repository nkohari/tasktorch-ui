_                             = require 'lodash'
React                         = require 'react/addons'
classSet                      = require 'common/util/classSet'
CachedState                   = require 'ui/framework/mixins/CachedState'
Caret                         = React.createFactory(require 'ui/common/Caret')
Icon                          = React.createFactory(require 'ui/common/Icon')
{a, div, ul, li, span, input} = React.DOM

SuggestingSelector = React.createClass {

  displayName: 'SuggestingSelector'

  mixins: [CachedState]

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

  getCachedState: (cache) ->
    if @state?.phrase?
      suggestions = {}
      for type in @types
        switch type
          when 'user' then suggestions.user = cache('suggestedUsers').get(@state.phrase)
          when 'team' then suggestions.team = cache('suggestedTeams').get(@state.phrase)
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
      Caret {}

  renderDropDown: ->

    if @state.suggestions?
      options = _.flatten _.map @types, (type) =>
        items = @state.suggestions[type]
        if items?
          return _.map items, (item) => @renderOption(type, item)

    div {className: 'drop'},
      div {className: 'suggest'},
        input {ref: 'input', type: 'text', value: @state.phrase, onChange: @onInputChanged}
        Icon {name: 'search'}
      ul {className: 'options'}, options

  renderOption: (type, item) ->

    classes = classSet [
      'option'
      'selected' if @state.selection?.id == item.id and @state.selectionType?.type == type
    ]

    li {key: item.id, className: classes, onClick: @onOptionSelected.bind(this, item, type)},
      @props.option {type: type, value: item}

  onTriggerClicked: (event) ->
    @setState {expanded: !@state.expanded}, =>
      if @state.expanded
        node = @refs.input.getDOMNode()
        node.focus()
        node.select()

  onInputChanged: (event) ->
    @setState {phrase: event.target.value}, =>
      @forceCacheSync()

  onOptionSelected: (item, type) ->
    @setState {expanded: false, selectionType: type, selection: item}
    @props.onChange(item, type) if @props.onChange?

}

module.exports = SuggestingSelector
