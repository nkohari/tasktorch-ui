_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Button    = React.createFactory(require 'ui/common/Button')
Frame     = React.createFactory(require 'ui/common/Frame')
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

ShellFooter = React.createClass {

  displayName: 'ShellFooter'

  mixins: [Router.State]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'shell-footer'}

}

module.exports = ShellFooter
