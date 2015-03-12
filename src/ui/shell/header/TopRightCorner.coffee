_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Frame       = React.createFactory(require 'ui/common/Frame')
OrgMenu     = React.createFactory(require 'ui/shell/header/OrgMenu')

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'top-right'},
      OrgMenu {currentOrg: @props.currentOrg}

}

module.exports = TopRightCorner
