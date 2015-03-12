React                   = require 'react'
KeyCode                 = require 'data/enums/KeyCode'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
UserCreatedCommentEvent = require 'events/ui/UserCreatedCommentEvent'
Avatar                  = React.createFactory(require 'ui/common/Avatar')
Button                  = React.createFactory(require 'ui/common/Button')
{div, span, textarea}   = React.DOM

CreateCommentForm = React.createClass {

  displayName: 'CreateCommentForm'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  mixins: [Actor]

  getInitialState: ->
    {text: ''}

  componentDidMount: ->
    node = @refs.textarea.getDOMNode()
    node.style.height = "#{@getHeight()}px"

  render: ->

    div {className: 'comment create-comment-form'},
      Avatar {className: 'comment-user', user: @props.currentUser}
      div {className: 'comment-body'},
        textarea {
          ref: 'textarea'
          placeholder: 'Write a comment'
          value: @state.text
          style: {height: @getHeight()} if @isMounted()
          @onKeyUp
          @onChange
        }
        div {className: 'create-comment-buttons'},
          Button {
            className: 'small'
            icon:      'add-comment'
            text:      'Add comment'
            onClick:   @createComment
          }

  onKeyUp: (event) ->
    if event.which == KeyCode.RETURN and event.shiftKey
      event.preventDefault()
      @createComment()

  onChange: (event) ->
    @setState {text: event.target.value}

  getHeight: ->
    return undefined unless @isMounted()
    node = @refs.textarea.getDOMNode()
    if node.scrollHeight == node.clientHeight
      node.style.height = 'auto'
    return node.scrollHeight

  createComment: ->
    return unless @state.text?.length > 0
    @publish new UserCreatedCommentEvent(@props.card.id, @state.text)
    @setState {text: ''}

}

module.exports = CreateCommentForm
