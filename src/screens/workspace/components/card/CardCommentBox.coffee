React          = require 'react'
PropTypes      = require 'common/PropTypes'
Observe        = require 'mixins/Observe'
Button         = React.createFactory(require 'common/Button')
CardCommentBox = React.createFactory(require './CardCommentBox')
{div, input}   = React.DOM

CardCommentBox = React.createClass {

  #--------------------------------------------------------------------------------

  displayName: 'CardCommentBox'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe()]

  #--------------------------------------------------------------------------------

  render: ->
    div {className: 'comment-box'}, [
      input {key: 'editor', className: 'comment', placeholder: 'Add a comment'}
      div {key: 'buttons', className: 'button-group'}, [
        Button {key: 'post',   className: 'small', icon: 'add-comment'}
        Button {key: 'attach', className: 'small', icon: 'add-file'}
      ]
    ]

  #--------------------------------------------------------------------------------
}

module.exports = CardCommentBox
