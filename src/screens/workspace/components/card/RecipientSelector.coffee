_                               = require 'lodash'
React                           = require 'react'
Observe                         = require 'mixins/Observe'
LoadRecipientSuggestionsRequest = require 'requests/LoadRecipientSuggestionsRequest'
Avatar                          = React.createFactory(require 'common/Avatar')
Icon                            = React.createFactory(require 'common/Icon')
{a, div, input, span, ul, li}   = React.DOM
{classSet}                      = React.addons

RecipientSelector = React.createClass {

  displayName: 'RecipientSelector'

  mixins: [Observe('suggestions')]

  getInitialState: ->
    {expanded: false, phrase: undefined, selection: undefined}

  getStateFromStores: (stores) ->
    if @state?.phrase?
      options = stores.suggestions.getSuggestions(@state.phrase)
    {options}

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
          input {key: 'input', type: 'text', value: @state.phrase, onChange: @onInputChanged}
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

    div {className: classSet(classes)}, _.compact [
      a {key: 'trigger', onClick: @onTriggerClicked}, [
        value
        span {key: 'indicator', className: 'indicator'}, [
          if @state.expanded then '\u25B4' else '\u25BE'
        ]
      ]
      drop if drop?
    ]

  renderUserOptionsGroup: ->
    _.map @state.options.users, (user) =>
      li {key: "user-#{user.id}", className: 'user option', 'data-type': 'user', 'data-id': user.id, onClick: @onUserClicked}, [
        Avatar {key: 'icon', size: 16, user}
        user.name
      ]

  renderTeamOptionsGroup: (teams) ->
    _.map @state.options.teams, (team) =>
      li {key: "team-#{team.id}", className: 'team option', 'data-type': 'team', 'data-id': team.id, onClick: @onTeamClicked}, [
        Icon {key: 'icon', name: 'users'}
        team.name
      ]

  onTriggerClicked: (event) ->
    @setState {expanded: !@state.expanded}

  onInputChanged: (event) ->
    phrase = event.target.value
    @execute new LoadRecipientSuggestionsRequest(phrase) if phrase.length > 0
    @setState {phrase}

  onUserClicked: (event) ->
    selection = {
      kind: 'user'
      item: _.find(@state.options.users, (user) -> user.id == event.target.dataset.id)
    }
    @setState {expanded: false, phrase: undefined, options: undefined, selection}

  onTeamClicked: (event) ->
    selection = {
      kind: 'team'
      item: _.find(@state.options.teams, (team) -> team.id == event.target.dataset.id)
    }
    @setState {expanded: false, phrase: undefined, options: undefined, selection}

}

module.exports = RecipientSelector
