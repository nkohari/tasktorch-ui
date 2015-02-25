React                = require 'react/addons'
Router               = require 'react-router'
UserSelectedOrgEvent = require 'events/ui/UserSelectedOrgEvent'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
UrlAware             = require 'ui/framework/mixins/UrlAware'
PropTypes            = require 'ui/framework/PropTypes'
UrlModel             = require 'ui/framework/UrlModel'
Frame                = React.createFactory(require 'ui/common/Frame')
ShellHeader          = React.createFactory(require 'ui/shell/header/ShellHeader')
ShellFooter          = React.createFactory(require 'ui/shell/footer/ShellFooter')
RouteHandler         = React.createFactory(Router.RouteHandler)
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)

Shell = React.createClass {

  displayName: 'Shell'

  propTypes:
    userid:     PropTypes.id
    orgid:      PropTypes.id
    currentUrl: PropTypes.object

  mixins: [Actor, CachedState, UrlAware]

  getCachedState: (cache) -> {
    orgs:        cache('myOrgs').get()
    currentUser: cache('users').get(@props.userid)
    currentOrg:  cache('orgs').get(@props.orgid)
  }

  componentDidMount: ->
    @publish new UserSelectedOrgEvent(@props.userid, @props.orgid)

  componentWillReceiveProps: (newProps) ->
    unless @props.userid == newProps.userid and @props.orgid == newProps.orgid
      @publish new UserSelectedOrgEvent(newProps.userid, newProps.orgid)

  isReady: ->
    @state.currentUser? and @state.currentOrg?

  render: ->
    currentUrl = @getCurrentUrl()
    Frame {@isReady, className: 'shell'},
      ShellHeader  {currentOrg: @state.currentOrg, currentUser: @state.currentUser}
      CSSTransitionGroup {component: 'div', className: 'shell-main', transitionName: 'navigate'},
        RouteHandler {key: currentUrl.getScreen(), currentOrg: @state.currentOrg, currentUser: @state.currentUser, sidebar: currentUrl.getSidebar()}
      ShellFooter  {currentOrg: @state.currentOrg, currentUser: @state.currentUser}

}

module.exports = Shell
