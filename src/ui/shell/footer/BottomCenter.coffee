_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM

BottomCenter = React.createClass {

  displayName: 'BottomCenter'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    div {className: 'bottom-center'},
      div {className: 'brand'},
        'TaskTorch'
        div {className: 'version'}, 'Alpha Version'

}

module.exports = BottomCenter