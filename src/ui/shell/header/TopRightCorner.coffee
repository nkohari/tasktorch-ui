_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Avatar    = React.createFactory(require 'ui/common/Avatar')
Frame     = React.createFactory(require 'ui/common/Frame')
Icon      = React.createFactory(require 'ui/common/Icon')

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  mixins: [Router.State]

  propTypes:
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'top-right'},
      Icon {name: 'settings'}
      Icon {name: 'logout'}
      Avatar {user: @props.currentUser}

}

module.exports = TopRightCorner
