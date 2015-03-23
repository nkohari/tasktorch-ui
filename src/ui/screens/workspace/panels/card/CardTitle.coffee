_                         = require 'lodash'
React                     = require 'react'
PropTypes                 = require 'ui/framework/PropTypes'
Actor                     = require 'ui/framework/mixins/Actor'
Pure                      = require 'ui/framework/mixins/Pure'
UserChangedCardTitleEvent = require 'events/ui/UserChangedCardTitleEvent'
Frame                     = React.createFactory(require 'ui/common/Frame')
EditableText              = React.createFactory(require 'ui/common/EditableText')

CardTitle = React.createClass {

  displayName: 'CardTitle'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, Pure]

  componentDidMount: ->
    @refs.text.getDOMNode().focus() unless @props.card.title

  render: ->
    Frame {className: 'card-title'},
      EditableText {
        ref:         'text'
        placeholder: 'Untitled Card'
        value:       @props.card.title
        save:        @onTitleChanged
      }

  onTitleChanged: (title) ->
    @publish new UserChangedCardTitleEvent(@props.card.id, title)

}

module.exports = CardTitle
