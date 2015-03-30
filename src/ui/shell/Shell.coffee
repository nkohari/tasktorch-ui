_                    = require 'lodash'
React                = require 'react/addons'
Router               = require 'react-router'
UserSelectedOrgEvent = require 'events/ui/UserSelectedOrgEvent'
PropTypes            = require 'ui/framework/PropTypes'
ScreenState          = require 'ui/framework/ScreenState'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
Frame                = React.createFactory(require 'ui/common/Frame')
LogOutDialog         = React.createFactory(require 'ui/dialogs/LogOutDialog')
TeamMembersDialog    = React.createFactory(require 'ui/dialogs/TeamMembersDialog')
TeamSettingsDialog   = React.createFactory(require 'ui/dialogs/TeamSettingsDialog')
UserSettingsDialog   = React.createFactory(require 'ui/dialogs/UserSettingsDialog')
DialogLayer          = React.createFactory(require 'ui/shell/DialogLayer')
ShellHeader          = React.createFactory(require 'ui/shell/header/ShellHeader')
ShellFooter          = React.createFactory(require 'ui/shell/footer/ShellFooter')
RouteHandler         = React.createFactory(Router.RouteHandler)
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)

Shell = React.createClass {

  displayName: 'Shell'

  propTypes:
    userid: PropTypes.id
    orgid:  PropTypes.id
    url:    PropTypes.object

  childContextTypes:
    currentScreen: PropTypes.string
    screenState:   PropTypes.object

  mixins: [Actor, CachedState, Router.Navigation]

  getChildContext: -> {
    currentScreen: @props.url.screen
    screenState:   @screenState
  }

  getCachedState: (cache) -> {
    orgs:        cache('myOrgs').get()
    currentUser: cache('users').get(@props.userid)
    currentOrg:  cache('orgs').get(@props.orgid)
  }

  componentWillMount: ->
    @screenState = {
      workspace:  new ScreenState('workspace',  @props.url, @transitionTo)
      bigpicture: new ScreenState('bigpicture', @props.url, @transitionTo)
      strategy:   new ScreenState('strategy',   @props.url, @transitionTo)
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
      currentOrg: @state.currentOrg
      currentUser: @state.currentUser
    }

    Frame {@isReady, className: 'shell'},
      ShellHeader {currentOrg: @state.currentOrg, currentUser: @state.currentUser}
      CSSTransitionGroup {component: 'div', className: 'shell-main', transitionName: 'navigate'},
        RouteHandler screenProps
      ShellFooter {currentOrg: @state.currentOrg, currentUser: @state.currentUser}
      DialogLayer {},
        LogOutDialog       {name: 'LogOut'}
        UserSettingsDialog {name: 'UserSettings'}
        TeamMembersDialog  {name: 'TeamMembers'}
        TeamSettingsDialog {name: 'TeamSettings'}

}

module.exports = Shell
