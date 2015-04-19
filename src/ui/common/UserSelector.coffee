_                   = require 'lodash'
React               = require 'react'
classSet            = require 'common/util/classSet'
dom                 = require 'common/util/dom'
PropTypes           = require 'ui/framework/PropTypes'
KeyCode             = require 'ui/framework/KeyCode'
CachedState         = require 'ui/framework/mixins/CachedState'
Avatar              = React.createFactory(require 'ui/common/Avatar')
Icon                = React.createFactory(require 'ui/common/Icon')
Input               = React.createFactory(require 'ui/common/Input')
SelectorOption      = React.createFactory(require 'ui/common/SelectorOption')
{div, span, li, ul} = React.DOM

UserSelector = React.createClass {

  displayName: 'UserSelector'

  mixins: [CachedState]

  props:
    onOptionSelected: PropTypes.func
    placeholder:      PropTypes.string

  getDefaultProps: ->
    {placeholder: "Start typing a user's name to search"}

  getInitialState: ->
    {expanded: false, text: undefined, highlight: -1}

  getCachedState: (cache) -> {
    users: cache('suggestedUsers').get(@state.text) if @state?.text?.length > 0
  }

  componentDidMount: ->
    document.addEventListener('click', @onClickOutside)

  componentDidUnmount: ->
    document.removeEventListener('click', @onClickOutside)

  render: ->

    if @state.expanded
      options = _.map @state.users, (user, index) =>
        SelectorOption {key: user.id, value: user, isHighlighted: @state.highlight == index, @highlight, @select},
          Avatar {user}
          span {className: 'text'}, user.name

    div {className: 'user-selector'},
      div {className: 'selector-prompt'},
        Input {ref: 'input', icon: 'user', rightIcon: 'search', placeholder: @props.placeholder, value: @state.text, @onKeyDown, onChange: @onInputChanged}
      ul {className: 'selector-options'}, options if @state.expanded

  onClickOutside: (event) ->
    return unless @isMounted()
    unless dom.hasAncestor(event.target, @getDOMNode())
      @setState {expanded: false}

  onKeyDown: (event) ->
    if event.which == KeyCode.RETURN and @state.highlight != -1
      @select(@state.users[@state.highlight])
    if event.which == KeyCode.UP and @state.highlight > -1
      @setState {highlight: @state.highlight - 1}
      event.preventDefault()
    if event.which == KeyCode.DOWN and @state.highlight < @state.users?.length - 1
      @setState {highlight: @state.highlight + 1}
      event.preventDefault()

  onInputChanged: (event) ->
    @setState {expanded: true, text: event.target.value}, => @forceCacheSync()

  highlight: (user) ->
    highlight = _.findIndex @state.users, (u) -> u.id == user.id
    @setState {highlight}

  select: (user) ->
    @setState {expanded: false, text: undefined, highlight: -1, users: undefined}
    @props.onOptionSelected(user)

}

module.exports = UserSelector
