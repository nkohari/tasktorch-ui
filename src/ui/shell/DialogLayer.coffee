_               = require 'lodash'
React           = require 'react/addons'
PropTypes       = require 'ui/framework/PropTypes'
DialogContainer = React.createFactory(require 'ui/common/DialogContainer')
{div}           = React.DOM

DialogLayer = React.createClass {

  displayName: 'DialogLayer'

  render: ->

    items = _.map @props.children, (dialog) =>
      DialogContainer {key: dialog.props.name, name: dialog.props.name}, dialog

    div {className: 'dialog-layer'},
      items

}

module.exports = DialogLayer
