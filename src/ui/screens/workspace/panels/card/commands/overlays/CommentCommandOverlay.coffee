#--------------------------------------------------------------------------------
React                   = require 'react'
UserCreatedCommentEvent = require 'events/ui/UserCreatedCommentEvent'
KeyCode                 = require 'ui/framework/KeyCode'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
CommandContext          = require 'ui/framework/mixins/CommandContext'
IdentityContext         = require 'ui/framework/mixins/IdentityContext'
Avatar                  = React.createFactory(require 'ui/common/Avatar')
Button                  = React.createFactory(require 'ui/common/Button')
TextArea                = React.createFactory(require 'ui/common/TextArea')
CardCommandOverlay      = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                   = React.DOM
#--------------------------------------------------------------------------------
require './CommentCommandOverlay.styl'
#--------------------------------------------------------------------------------

CommentCommandOverlay = React.createClass {

  displayName: 'CommentCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext, IdentityContext]

  getInitialState: ->
    {text: ''}

  componentDidMount: ->
    @refs.textarea.focus()

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Add Comment', className: 'default', disabled: !@isValid(), onClick: @createComment}
      Button {text: 'Cancel', onClick: @hideCommand}

    CardCommandOverlay {className: 'create-comment', buttons},
      div {className: 'create-comment-form'},
        Avatar {className: 'comment-user', user: @getCurrentUser(), size: 32}
        TextArea {
          ref: 'textarea'
          flexible: true
          placeholder: 'Write a comment'
          value: @state.text
          rows: 5
          @onKeyUp
          @onChange
        }

  isValid: ->
    @state.text?.length > 0

  onKeyUp: (event) ->
    if event.which == KeyCode.RETURN and event.shiftKey
      event.preventDefault()
      @createComment()

  onChange: (event) ->
    @setState {text: event.target.value}

  createComment: (preempt) ->
    @publish new UserCreatedCommentEvent(@props.card.id, @state.text)
    @hideCommand()

}

module.exports = CommentCommandOverlay
