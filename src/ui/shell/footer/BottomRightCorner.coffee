_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM

BottomRightCorner = React.createClass {

  displayName: 'BottomRightCorner'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    div {className: 'bottom-right'},
      div {className: 'brand'},
        'TaskTorch'
        div {className: 'version'}, 'Alpha Version'

}

module.exports = BottomRightCorner
