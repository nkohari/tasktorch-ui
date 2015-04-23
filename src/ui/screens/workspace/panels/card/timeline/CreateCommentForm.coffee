React                   = require 'react'
KeyCode                 = require 'ui/framework/KeyCode'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ShellContext            = require 'ui/framework/mixins/ShellContext'
UserCreatedCommentEvent = require 'events/ui/UserCreatedCommentEvent'
Avatar                  = React.createFactory(require 'ui/common/Avatar')
Button                  = React.createFactory(require 'ui/common/Button')
TextArea                = React.createFactory(require 'ui/common/TextArea')
{div, span}             = React.DOM

CreateCommentForm = React.createClass {

  displayName: 'CreateCommentForm'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, ShellContext]

  getInitialState: ->
    {text: ''}

  render: ->

    div {className: 'comment create-comment-form'},
      Avatar {className: 'comment-user', user: @getCurrentUser()}
      div {className: 'comment-body'},
        TextArea {
          flexible: true
          placeholder: 'Write a comment'
          value: @state.text
          rows: 3
          @onKeyUp
          @onChange
        }
        div {className: 'create-comment-buttons'},
          Button {
            className: 'small'
            icon:      'comment'
            text:      'Add comment'
            onClick:   @createComment
          }

  onKeyUp: (event) ->
    if event.which == KeyCode.RETURN and event.shiftKey
      event.preventDefault()
      @createComment()

  onChange: (event) ->
    @setState {text: event.target.value}

  createComment: ->
    return unless @state.text?.length > 0
    @publish new UserCreatedCommentEvent(@props.card.id, @state.text)
    @setState {text: ''}

}

module.exports = CreateCommentForm
