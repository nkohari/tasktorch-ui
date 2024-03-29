#--------------------------------------------------------------------------------
_                         = require 'lodash'
React                     = require 'react'
PropTypes                 = require 'ui/framework/PropTypes'
Actor                     = require 'ui/framework/mixins/Actor'
Pure                      = require 'ui/framework/mixins/Pure'
UserChangedCardTitleEvent = require 'events/ui/UserChangedCardTitleEvent'
Frame                     = React.createFactory(require 'ui/common/Frame')
EditableTextArea          = React.createFactory(require 'ui/common/EditableTextArea')
#--------------------------------------------------------------------------------
require './CardTitle.styl'
#--------------------------------------------------------------------------------

CardTitle = React.createClass {

  displayName: 'CardTitle'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, Pure]

  componentDidMount: ->
    @refs.input.focus() unless @props.card.title?.length > 0

  render: ->
    Frame {className: 'card-title'},
      EditableTextArea {
        ref:         'input'
        rows:        1
        placeholder: 'What do you want to accomplish?'
        value:       @props.card.title
        save:        @onTitleChanged
      }

  onTitleChanged: (title) ->
    @publish new UserChangedCardTitleEvent(@props.card.id, title)

}

module.exports = CardTitle
