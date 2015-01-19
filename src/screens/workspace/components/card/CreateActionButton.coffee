React               = require 'react'
PropTypes           = require 'common/PropTypes'
Observe             = require 'mixins/Observe'
CreateActionRequest = require 'requests/CreateActionRequest'
Icon                = React.createFactory(require 'common/Icon')
Button              = React.createFactory(require 'common/Button')

CreateActionButton = React.createClass {

  displayName: 'CreateActionButton'

  propTypes:
    card:  PropTypes.Card
    stage: PropTypes.Stage

  mixins: [Observe()]

  render: ->
    Button {
      className: 'small'
      icon:      'action'
      text:      'Add Action to Stage'
      onClick:   @createAction
    }

  createAction: ->
    @execute new CreateActionRequest(@props.card, @props.stage)

}

module.exports = CreateActionButton
