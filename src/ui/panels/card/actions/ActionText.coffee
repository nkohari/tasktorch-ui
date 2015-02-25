React                      = require 'react'
PropTypes                  = require 'ui/framework/PropTypes'
Actor                      = require 'ui/framework/mixins/Actor'
Pure                       = require 'ui/framework/mixins/Pure'
UserChangedActionTextEvent = require 'events/ui/UserChangedActionTextEvent'
EditableText               = React.createFactory(require 'ui/common/EditableText')

ActionText = React.createClass {

  displayName: 'ActionText'

  propTypes:
    action: PropTypes.Action

  mixins: [Actor, Pure]

  render: ->
    EditableText {
      className:   'text'
      value:       @props.action.text
      save:        @setActionText
      placeholder: 'Action Text'
    }

  setActionText: (value) ->
    @publish new UserChangedActionTextEvent(@props.action.id, value)

}

module.exports = ActionText
