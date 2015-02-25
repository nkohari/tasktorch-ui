_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Button    = React.createFactory(require 'ui/common/Button')

SearchButton = React.createClass {

  displayName: 'SearchButton'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->
    Button {className: 'search', icon: 'search'}

}

module.exports = SearchButton
