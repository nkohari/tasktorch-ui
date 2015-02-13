_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Frame     = React.createFactory(require 'ui/common/Frame')
{div}     = React.DOM

BottomRightCorner = React.createClass {

  displayName: 'BottomRightCorner'

  mixins: [Router.State]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'bottom-right'},
      div {className: 'brand'},
        'TaskTorch'
        div {className: 'version'}, 'Alpha Version'

}

module.exports = BottomRightCorner
