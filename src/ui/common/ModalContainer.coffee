#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'ui/framework/PropTypes'
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
RouteHandler       = React.createFactory(Router.RouteHandler)
{div}              = React.DOM
{cloneWithProps}   = React.addons
#--------------------------------------------------------------------------------
require './ModalContainer.styl'
#--------------------------------------------------------------------------------

ModalContainer = React.createClass {

  displayName: 'ModalContainer'

  propTypes:
    location: PropTypes.object
    params:   PropTypes.object

  render: ->

    modal = cloneWithProps @props.children, {
      key:    @props.location.pathname
      params: @props.params
      query:  @props.location.query
    }

    div {className: 'modal-container'},
      CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide', transitionAppear: true},
        modal

}

module.exports = ModalContainer
