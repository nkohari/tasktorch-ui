_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
List           = React.createFactory(require 'ui/common/List')
ListItem       = React.createFactory(require 'ui/common/ListItem')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')

OrgMenu = React.createClass {

  displayName: 'OrgMenu'

  propTypes:
    currentOrg: PropTypes.Org

  render: ->

    overlay = List {className: 'overlay menu'},
      ListItem {}, 'Create a team'

    OverlayTrigger {className: 'org menu-button', overlay},
      Button {text: @props.currentOrg.name, caret: true}

}

module.exports = OrgMenu
