#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
classSet            = require 'common/util/classSet'
KeyCode             = require 'ui/framework/KeyCode'
PropTypes           = require 'ui/framework/PropTypes'
CachedState         = require 'ui/framework/mixins/CachedState'
Caret               = React.createFactory(require 'ui/common/Caret')
Icon                = React.createFactory(require 'ui/common/Icon')
Input               = React.createFactory(require 'ui/common/Input')
OptionList          = React.createFactory(require 'ui/common/OptionList')
OptionListSeparator = React.createFactory(require 'ui/common/OptionListSeparator')
EmptyOption         = React.createFactory(require 'ui/options/EmptyOption')
{cloneWithProps}    = React.addons
{a, div, span}      = React.DOM
#--------------------------------------------------------------------------------
require './SuggestingSelector.styl'
#--------------------------------------------------------------------------------

SuggestingSelector = React.createClass {

  displayName: 'SuggestingSelector'

  propTypes:
    component: PropTypes.func
    value:     PropTypes.any

  mixins: [CachedState]

  getInitialState: ->
    {text: undefined}

  getCachedState: (cache) ->
    if @state?.text?.length > 0
      suggestions = {}
      for group in @props.groups
        switch group.type
          when 'user' then suggestions.user = cache('suggestedUsers').get(@state.text)
          when 'team' then suggestions.team = cache('suggestedTeams').get(@state.text)
    {suggestions}

  componentDidUpdate: ->
    @refs.input?.focus() unless @state.text?.length > 0

  render: ->

    if @props.value?
      value = div {className: 'selector-trigger', onClick: @clear},
        @props.component {value: @props.value}
        Icon {name: 'remove'}
    else
      value = Input {
          ref: 'input'
          rightIcon: 'search'
          className: 'selector-input'
          placeholder: @props.placeholder
          value: @state.text
          onKeyDown: @onKeyDown
          onChange: @onInputChanged
        }

    classes = classSet [
      'suggesting-selector'
      'expanded' if @state.suggestions?
    ]

    div {className: classes},
      value
      @renderOptions() if @state.text?.length > 0

  renderOptions: ->

    hasSuggestions = _.any @props.groups, (group) => @state.suggestions?[group.type]?.length > 0

    unless hasSuggestions
      items = [EmptyOption {}]
    else
      items = _.flatten _.map @props.groups, (group, index) =>
        items = _.compact @state.suggestions[group.type]
        return unless items?.length > 0
        return _.map items, (item) =>
          @props.component {value: {type: group.type, item}}

    OptionList {ref: 'list', className: 'selector-options', onSelect: @select}, items

  focus: ->
    @refs.input.focus()

  clear: ->
    @props.onChange(undefined) if @props.onChange?

  select: (value) ->
    @setState {text: undefined, suggestions: undefined}
    @props.onChange(value) if @props.onChange?

  onInputChanged: (event) ->
    @setState {text: event.target.value}, => @forceCacheSync()

  onKeyDown: (event) ->
    switch event.which
      when KeyCode.DOWN
        @refs.list.highlightNext()
        event.preventDefault()
      when KeyCode.UP
        @refs.list.highlightPrevious()
        event.preventDefault()
      when KeyCode.RETURN
        @select(@refs.list.getValue())
        event.preventDefault()
      when KeyCode.ESCAPE
        @props.closeOverlay()
        event.preventDefault()

}

module.exports = SuggestingSelector
