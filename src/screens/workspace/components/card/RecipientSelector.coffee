_                               = require 'lodash'
React                           = require 'react'
Observe                         = require 'mixins/Observe'
LoadRecipientSuggestionsRequest = require 'requests/LoadRecipientSuggestionsRequest'
Avatar                          = React.createFactory(require 'common/Avatar')
Icon                            = React.createFactory(require 'common/Icon')
{a, div, input, span, ul, li}   = React.DOM
{classSet}                      = React.addons

RecipientSelector = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'RecipientSelector'

  mixins: [Observe('suggestions')]

  getInitialState: ->
    {expanded: false, phrase: undefined, selection: undefined}

  # Lifecycle ---------------------------------------------------------------------
  # State -------------------------------------------------------------------------

  sync: (stores) ->
    if @state?.phrase?
      options = stores.suggestions.get(@state.phrase)
      console.log "Phrase = #{@state.phrase}, new options: %O", options
    {options}

  # Rendering ---------------------------------------------------------------------

  render: ->

    options = []
    if @state.options?
      options = _.flatten [
        @renderUserOptionsGroup()
        @renderTeamOptionsGroup()
      ]

    if @state.expanded
      drop = div {key: 'drop', className: 'drop'}, [
        div {key: 'suggest', className: 'suggest'}, [
          input {key: 'input', ref: 'input', type: 'text', value: @state.phrase, onChange: @onInputChanged}
          span {key: 'icon', className: 'indicator'}, ['\uD83D\uDD0D']
        ]
        ul {key: 'options', className: 'options'}, options
      ]

    if @state.selection?
      value = span {key: 'value', className: 'value'}, [@state.selection.item.name]
    else
      value = span {key: 'value', className: 'placeholder value'}, [@props.placeholder ? 'Recipient']

    classes =
      recipient: true
      selector:  true
      expanded:  @state.expanded
      empty:     not @state.selection?

    div {className: classSet(classes), tabIndex: -1, onBlur: @onBlur}, [
      a {key: 'trigger', onClick: @onTriggerClicked}, [
        value
        span {key: 'indicator', className: 'indicator'}, [
          if @state.expanded then '\u25B4' else '\u25BE'
        ]
      ]
      drop if drop?
    ]

  # Events ------------------------------------------------------------------------

  onTriggerClicked: (event) ->
    expanded = !@state.expanded
    @setState {expanded}, =>
      @refs.input.getDOMNode().focus() if expanded

  onInputChanged: (event) ->
    phrase = event.target.value
    @setState {phrase}, =>
      @execute new LoadRecipientSuggestionsRequest(phrase) if phrase.length > 0

  onOptionClicked: (kind, item, event) ->
    selection = {kind, item}
    @setState {expanded: false, phrase: undefined, options: undefined, selection}
    @props.onChange(selection) if @props.onChange?

  onBlur: ->
    # TODO
    console.log('blur')

  # Utility -----------------------------------------------------------------------

  renderUserOptionsGroup: ->
    _.map @state.options.users, (user) =>
      li {key: "user-#{user.id}", className: 'user option', onClick: @onOptionClicked.bind(null, 'user', user)}, [
        Avatar {key: 'icon', size: 16, user}
        user.name
      ]

  renderTeamOptionsGroup: (teams) ->
    _.map @state.options.teams, (team) =>
      li {key: "team-#{team.id}", className: 'team option', onClick: @onOptionClicked.bind(null, 'team', team)}, [
        Icon {key: 'icon', name: 'users'}
        team.name
      ]

  #--------------------------------------------------------------------------------

}

module.exports = RecipientSelector
