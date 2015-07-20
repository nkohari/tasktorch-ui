#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
UserOption = React.createFactory(require 'ui/options/UserOption')
TeamOption = React.createFactory(require 'ui/options/TeamOption')
#--------------------------------------------------------------------------------

UserOrTeamOption = React.createClass {

  displayName: 'UserOrTeamOption'

  propTypes:
    value:         PropTypes.object
    isHighlighted: PropTypes.bool

  render: ->

    {item, type} = @props.value

    props = mergeProps _.omit(@props, 'value'), {
      value: item
    }

    switch type
      when 'user' then UserOption(props)
      when 'team' then TeamOption(props)

}

module.exports = UserOrTeamOption
