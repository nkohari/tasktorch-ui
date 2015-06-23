#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react/addons'
Router             = require 'react-router'
PropTypes          = require 'ui/framework/PropTypes'
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
RouteHandler       = React.createFactory(Router.RouteHandler)
{div}              = React.DOM
#--------------------------------------------------------------------------------
require './ModalContainer.styl'
#--------------------------------------------------------------------------------

ModalContainer = React.createClass {

  displayName: 'ModalContainer'

  propTypes:
    url: PropTypes.object

  render: ->

    div {className: 'modal-container'},
      CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide', transitionAppear: true},
        RouteHandler {ref: 'modal', key: @props.url.screen, url: @props.url}

}

module.exports = ModalContainer
