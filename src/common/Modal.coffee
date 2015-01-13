React              = require 'react/addons'
PropTypes          = require 'common/PropTypes'
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

Modal = React.createClass {

  displayName: 'Modal'

  propTypes:
    visible: PropTypes.bool

  render: ->
    if @props.visible
      children = @content()
    else
      children = []
    div {className: 'modal'}, children

  content: ->
    return [
      div {className: 'modal-content'}, @props.children
      div {className: 'modal-shadow'}
    ]

}

module.exports = Modal
