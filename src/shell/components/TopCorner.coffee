React       = require 'react'
Avatar      = React.createFactory(require 'common/Avatar')
{div, span} = React.DOM

TopCorner = React.createClass {

  displayName: 'TopCorner'

  render: ->
    div {className: 'top corner'}, [
      Avatar {key: 'avatar', user: @props.currentUser}
      div {key: 'context', className: 'context'}, [
        div {key: 'user', className: 'user'}, [@props.currentUser.name]
        div {key: 'organization', className: 'organization'}, [@props.currentOrganization.name]
      ]
    ]

}

module.exports = TopCorner
