#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react/addons'
Router               = require 'react-router'
UserSelectedOrgEvent = require 'events/ui/UserSelectedOrgEvent'
PropTypes            = require 'ui/framework/PropTypes'
ScreenState          = require 'ui/framework/ScreenState'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
Frame                = React.createFactory(require 'ui/common/Frame')
DialogLayer          = React.createFactory(require 'ui/shell/DialogLayer')
ShellHeader          = React.createFactory(require 'ui/shell/header/ShellHeader')
ShellFooter          = React.createFactory(require 'ui/shell/footer/ShellFooter')
RouteHandler         = React.createFactory(Router.RouteHandler)
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)
{div}                = React.DOM
#--------------------------------------------------------------------------------
require 'shell/Shell.styl'
#--------------------------------------------------------------------------------

Shell = React.createClass {

  displayName: 'Shell'

  propTypes:
    userid: PropTypes.id
    orgid:  PropTypes.id
    url:    PropTypes.object

  childContextTypes:
    currentOrg:    PropTypes.Org
    currentUser:   PropTypes.User
    currentScreen: PropTypes.string
    screenState:   PropTypes.object

  mixins: [Actor, CachedState, Router.Navigation]

  getChildContext: -> {
    currentScreen: @props.url.screen
    screenState:   @screenState
    currentOrg:    @state.currentOrg
    currentUser:   @state.currentUser
  }

  getCachedState: (cache) -> {
    orgs:        cache('myOrgs').get()
    currentOrg:  cache('orgs').get(@props.orgid)
    currentUser: cache('users').get(@props.userid)
  }

  componentWillMount: ->
    Environment.cache.clear()
    @screenState = {
      workspace:  new ScreenState('workspace',  @props.url, @transitionTo)
      bigpicture: new ScreenState('bigpicture', @props.url, @transitionTo)
      strategy:   new ScreenState('strategy',   @props.url, @transitionTo)
      knowledge:  new ScreenState('knowledge',  @props.url, @transitionTo)
    }

  componentDidMount: ->
    @publish new UserSelectedOrgEvent(@props.userid, @props.orgid)

  componentWillReceiveProps: (newProps) ->
    unless @props.userid == newProps.userid and @props.orgid == newProps.orgid
      @publish new UserSelectedOrgEvent(newProps.userid, newProps.orgid)

  isReady: ->
    @state.currentUser? and @state.currentOrg?

  render: ->

    screenProps = _.extend @screenState[@props.url.screen], {
      key: @props.url.screen
    }

    Frame {@isReady, className: 'shell'},
      ShellHeader {}
      CSSTransitionGroup {component: 'div', className: 'shell-main', transitionName: 'navigate'},
        RouteHandler screenProps
      ShellFooter {}
      DialogLayer {}
      div {id: 'intercom', style: {display: 'none'}}

}

module.exports = Shell
