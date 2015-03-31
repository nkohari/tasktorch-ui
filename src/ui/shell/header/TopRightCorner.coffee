_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Frame          = React.createFactory(require 'ui/common/Frame')
OrgContextMenu = React.createFactory(require 'ui/shell/header/OrgContextMenu')

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'top-right'},
      OrgContextMenu {currentOrg: @props.currentOrg}

}

module.exports = TopRightCorner
