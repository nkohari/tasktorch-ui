React             = require 'react'
PropTypes         = require 'framework/PropTypes'
KeyCode           = require 'framework/enums/KeyCode'
Observe           = require 'framework/mixins/Observe'
CreateNoteRequest = require 'requests/CreateNoteRequest'
Button            = React.createFactory(require 'ui/common/Button')
CardCommentBox    = React.createFactory(require 'ui/panels/card/CardCommentBox')
{div, input}      = React.DOM

CardCommentBox = React.createClass {

  displayName: 'CardCommentBox'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe()]

  getInitialState: ->
    {text: undefined}

  render: ->

    div {className: 'comment-box'},
      input {
        className:   'comment'
        placeholder: 'Add a comment'
        value:       @state.text
        onKeyUp:     @onTextKeyUp
        onChange:    @onTextChanged
      }
      div {className: 'button-group'},
        Button {
          className: 'small'
          icon:      'add-comment'
          disabled:  not(@state.text?.length > 0)
          onClick:   @createComment
        }
        Button {
          className: 'small'
          icon:      'add-file'
        }

  onTextKeyUp: (event) ->
    switch event.which
      when KeyCode.RETURN then @createComment()

  onTextChanged: (event) ->
    @setState {text: event.target.value}

  createComment: ->
    @execute new CreateNoteRequest(@props.card, 'Comment', @state.text)
    @setState {text: undefined}

}

module.exports = CardCommentBox
