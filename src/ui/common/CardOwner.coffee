_         = require 'lodash'
React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
Avatar    = React.createFactory(require 'ui/common/Avatar')
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

CardOwner = React.createClass {

  displayName: 'CardOwner'

  propTypes:
    user: PropTypes.User

  render: ->

    if @props.user?
      Avatar {className: 'owner', user: @props.user}
    else
      div {className: 'team owner'},
        Icon {name: 'team'}

}

module.exports = CardOwner
