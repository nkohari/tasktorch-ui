_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
ContextMenu   = React.createFactory(require 'ui/common/ContextMenu')
DialogTrigger = React.createFactory(require 'ui/common/DialogTrigger')
Icon          = React.createFactory(require 'ui/common/Icon')
{div}         = React.DOM

MyWorkContextMenu = React.createClass {

  displayName: 'MyWorkContextMenu'

  propTypes:
    hideOverlay: PropTypes.func

  render: ->

    ContextMenu {hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'CreateStack', team: @props.team},
        Icon {name: 'stack-backlog'}
        'Create a new stack'

}

module.exports = MyWorkContextMenu
