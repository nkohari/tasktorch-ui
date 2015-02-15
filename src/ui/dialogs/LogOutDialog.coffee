React     = require 'react'
PropTypes = require 'framework/PropTypes'
Button    = React.createFactory(require 'ui/common/Button')
Dialog    = React.createFactory(require 'ui/common/Dialog')
{div}     = React.DOM

LogOutDialog = React.createClass {

  displayName: 'LogOutDialog'

  render: ->

    Dialog {},
      'Log out'

}

module.exports = LogOutDialog
