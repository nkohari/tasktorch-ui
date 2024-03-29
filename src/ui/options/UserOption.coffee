#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
classSet        = require 'common/util/classSet'
mergeProps      = require 'common/util/mergeProps'
PropTypes       = require 'ui/framework/PropTypes'
IdentityContext = require 'ui/framework/mixins/IdentityContext'
Avatar          = React.createFactory(require 'ui/common/Avatar')
Icon            = React.createFactory(require 'ui/common/Icon')
{div, span}     = React.DOM
#--------------------------------------------------------------------------------
require './UserOption.styl'
#--------------------------------------------------------------------------------

UserOption = React.createClass {

  displayName: 'UserOption'

  propTypes:
    value:         PropTypes.User
    isHighlighted: PropTypes.bool

  mixins: [IdentityContext]

  render: ->

    if @props.value?
      icon = Avatar {user: @props.value}
      if @props.value.id == @getCurrentUser().id
        text = "#{@props.value.name} (You)"
      else
        text = @props.value.name
    else
      icon = Icon {name: 'user'}
      text = "No one"

    props = mergeProps _.omit(@props, 'value', 'isHighlighted'), {
      className: classSet [
        'user-option'
        'highlighted' if @props.isHighlighted
      ]
    }

    div props,
      icon
      span {className: 'text'}, text

}

module.exports = UserOption
