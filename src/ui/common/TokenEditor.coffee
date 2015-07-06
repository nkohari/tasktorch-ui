#--------------------------------------------------------------------------------
_                      = require 'lodash'
React                  = require 'react'
KeyCode                = require 'ui/framework/KeyCode'
PropTypes              = require 'ui/framework/PropTypes'
Avatar                 = React.createFactory(require 'ui/common/Avatar')
Button                 = React.createFactory(require 'ui/common/Button')
Icon                   = React.createFactory(require 'ui/common/Icon')
Input                  = React.createFactory(require 'ui/common/Input')
{a, div, span, ul, li} = React.DOM
#--------------------------------------------------------------------------------
require('./TokenEditor.styl')
#--------------------------------------------------------------------------------

TokenEditor = React.createClass {

  displayName: 'TokenEditor'

  props:
    org:      PropTypes.Org
    value:    PropTypes.arrayOf(PropTypes.object)
    onChange: PropTypes.func

  getInitialState: ->
    {currentEmail: ''}

  componentDidMount: ->
    @refs.input.focus()

  componentDidUpdate: ->
    node = @refs.list.getDOMNode()
    node.scrollTop = node.scrollHeight

  render: ->

    tokens = _.map @props.value, (token, index) =>
      li {key: index, className: 'token'},
        span {className: 'number'}, index + 1
        Avatar {email: token.email}
        span {className: 'email'}, token.email
        a {className: 'remove', onClick: @onRemoveClicked.bind(null, index)},
          Icon {name: 'remove'}

    div {className: 'token-editor'},
      div {className: 'add-token'},
        Input {ref: 'input', icon: 'email', value: @state.currentEmail, @onKeyUp, @onChange}
        a {onClick: @onAddClicked},
          Icon {name: 'add'}
      ul {ref: 'list', className: 'token-list'},
        tokens

  onChange: (event) ->
    @setState {currentEmail: event.target.value}

  onKeyUp: (event) ->
    if event.which is KeyCode.RETURN
      event.stopPropagation()
      @addToken(event.target.value)

  onAddClicked: ->
    @addToken(@state.currentEmail)

  onRemoveClicked: (index) ->
    tokens = _.clone(@props.value)
    tokens.splice(index, 1)
    @props.onChange(tokens)

  addToken: (email) ->
    return unless email?.length > 0
    token = {email}
    tokens = _.clone(@props.value).concat [token]
    @props.onChange(tokens)
    @setState {currentEmail: ''}

}

module.exports = TokenEditor
