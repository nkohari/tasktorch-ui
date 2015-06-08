_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')

CommentCommandButton = React.createClass {

  displayName: 'CommentCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'comment'
      text:    'Comment'
      command: CardCommandType.Comment
    }

}

module.exports = CommentCommandButton
