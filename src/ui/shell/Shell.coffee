#--------------------------------------------------------------------------------
_                    = require 'lodash'
cookies              = require 'cookies-js'
React                = require 'react'
Router               = require 'react-router'
compare              = require 'common/util/compare'
UserSelectedOrgEvent = require 'events/ui/UserSelectedOrgEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
ViewContext          = require 'ui/framework/mixins/ViewContext'
Frame                = React.createFactory(require 'ui/common/Frame')
DialogLayer          = React.createFactory(require 'ui/shell/DialogLayer')
ShellHeader          = React.createFactory(require 'ui/shell/header/ShellHeader')
ShellFooter          = React.createFactory(require 'ui/shell/footer/ShellFooter')
Walkthrough          = React.createFactory(require 'ui/walkthrough/Walkthrough')
RouteHandler         = React.createFactory(Router.RouteHandler)
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)
{div}                = React.DOM
{cloneWithProps}     = React.addons
#--------------------------------------------------------------------------------
require './Shell.styl'
#--------------------------------------------------------------------------------

Shell = React.createClass {

  displayName: 'Shell'

  propTypes:
    identity: PropTypes.object

  mixins: [Actor, CachedState, ViewContext]

  contextTypes:
    environment: PropTypes.object

  childContextTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  getChildContext: -> {
    currentOrg:  @state.currentOrg
    currentUser: @state.currentUser
  }

  getCachedState: (cache) -> {
    orgs:        cache('myOrgs').get()
    currentOrg:  cache('orgs').get(@props.identity.orgid)
    currentUser: cache('users').get(@props.identity.userid)
  }

  componentWillMount: ->
    @context.environment.get('cache').clear()

  componentDidMount: ->
    @publish new UserSelectedOrgEvent(@props.identity.userid, @props.identity.orgid)

  componentWillReceiveProps: (newProps) ->
    unless compare.hashes(@props.identity, newProps.identity)
      @publish new UserSelectedOrgEvent(newProps.identity.userid, newProps.identity.orgid)

  isReady: ->
    @state.currentUser? and @state.currentOrg?

  render: ->

    screen = cloneWithProps @props.children, {
      key: @getCurrentScreen()
    }

    Frame {@isReady, className: 'shell'},
      ShellHeader {}
      CSSTransitionGroup {component: 'div', className: 'shell-main', transitionName: 'navigate'},
        screen
      ShellFooter {}
      DialogLayer {}
      div {id: 'intercom', style: {display: 'none'}}
      Walkthrough {} unless @state.currentUser?.hasCompletedWalkthrough()

}

module.exports = Shell
