#--------------------------------------------------------------------------------
React                      = require 'react'
PropTypes                  = require 'ui/framework/PropTypes'
Actor                      = require 'ui/framework/mixins/Actor'
Pure                       = require 'ui/framework/mixins/Pure'
UserChangedActionTextEvent = require 'events/ui/UserChangedActionTextEvent'
EditableTextArea           = React.createFactory(require 'ui/common/EditableTextArea')
#--------------------------------------------------------------------------------

CardActionText = React.createClass {

  displayName: 'CardActionText'

  propTypes:
    action: PropTypes.Action

  mixins: [Actor, Pure]

  render: ->
    EditableTextArea {
      rows:        1
      className:   'card-action-text'
      value:       @props.action.text
      save:        @setActionText
      placeholder: 'Action Text'
    }

  setActionText: (value) ->
    @publish new UserChangedActionTextEvent(@props.action.id, value)

}

module.exports = CardActionText
