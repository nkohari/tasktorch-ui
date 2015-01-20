React                          = require 'react'
PropTypes                      = require 'common/PropTypes'
Observe                        = require 'mixins/Observe'
ActionCommand                  = require 'framework/enums/ActionCommand'
ChangeActionStatusCommandPanel = React.createFactory(require './commands/ChangeActionStatusCommandPanel')
ChangeActionOwnerCommandPanel  = React.createFactory(require './commands/ChangeActionOwnerCommandPanel')
DeleteActionCommandPanel       = React.createFactory(require './commands/DeleteActionCommandPanel')

ActionCommandFrame = React.createClass {

  displayName: 'ActionCommandFrame'

  propTypes:
    action:      PropTypes.Action
    command:     PropTypes.string
    showCommand: PropTypes.func
    hideCommand: PropTypes.func

  mixins: [Observe()]

  render: ->

    props =
      action:      @props.action
      hideCommand: @props.hideCommand

    switch @props.command
      when ActionCommand.ChangeStatus then ChangeActionStatusCommandPanel(props)
      when ActionCommand.ChangeOwner  then ChangeActionOwnerCommandPanel(props)
      when ActionCommand.Delete       then DeleteActionCommandPanel(props)

}

module.exports = ActionCommandFrame
