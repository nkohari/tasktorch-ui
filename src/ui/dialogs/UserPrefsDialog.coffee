React     = require 'react'
PropTypes = require 'framework/PropTypes'
Button    = React.createFactory(require 'ui/common/Button')
Dialog    = React.createFactory(require 'ui/common/Dialog')
{div}     = React.DOM

UserPrefsDialog = React.createClass {

  displayName: 'UserPrefsDialog'

  render: ->

    Dialog {},
      'User preferences'

}

module.exports = UserPrefsDialog
