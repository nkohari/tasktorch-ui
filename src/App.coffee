#--------------------------------------------------------------------------------
_                 = require 'lodash'
{createHistory}   = require 'history'
React             = require 'react'
ReactRouter       = require 'react-router'
Analytics         = require 'common/Analytics'
Environment       = require './Environment'
PropTypes         = require 'ui/framework/PropTypes'
Identity          = require 'ui/framework/Identity'
Shell             = require 'ui/shell/Shell'
NotFoundBanner    = require 'ui/banners/NotFoundBanner'
ModalContainer    = require 'ui/common/ModalContainer'
CreateOrgModal    = require 'ui/modals/CreateOrgModal'
SendInvitesModal  = require 'ui/modals/SendInvitesModal'
LoginModal        = require 'ui/modals/LoginModal'
AcceptInviteModal = require 'ui/modals/AcceptInviteModal'
SelectOrgModal    = require 'ui/modals/SelectOrgModal'
SignUpModal       = require 'ui/modals/SignUpModal'
WorkspaceScreen   = require 'ui/screens/workspace/WorkspaceScreen'
BigPictureScreen  = require 'ui/screens/bigPicture/BigPictureScreen'
Router            = React.createFactory(ReactRouter.Router)
Route             = React.createFactory(ReactRouter.Route)
{cloneWithProps}  = React.addons
{div} = React.DOM
#--------------------------------------------------------------------------------
require './App.styl'
#--------------------------------------------------------------------------------

window.debug = require('common/util/debug')

App = React.createClass {

  displayName: 'App'

  childContextTypes:
    environment: PropTypes.object
    currentView: PropTypes.object

  getChildContext: -> {
    environment: @state.environment
    currentView: @state.environment.get('viewMaster').getCurrentView()
  }

  componentWillMount: ->
    environment = new Environment(@props.history)
    viewMaster  = environment.get('viewMaster')
    @syncWithViewMaster(viewMaster, @props)
    @setState {environment}

  componentWillReceiveProps: (newProps) ->
    viewMaster = @state.environment.get('viewMaster')
    @syncWithViewMaster(viewMaster, newProps)

  componentDidUpdate: ->
    Analytics.update()

  render: ->
    return div {} unless @props.children?
    cloneWithProps @props.children, {
      identity: @state.environment.get('viewMaster').getIdentity()
    }

  syncWithViewMaster: (viewMaster, props) ->
    if not props.children?
      if viewMaster.getCurrentScreen()?
        viewMaster.navigate()
        viewMaster.setIdentity(new Identity(props.params))
      else
        props.history.pushState(null, '/x/login')
    else
      viewMaster.setLocation(props.location)
      viewMaster.setIdentity(new Identity(props.params))

}

router = Router {history: createHistory()},
  Route {path: '/', component: App},
    Route {path: 'x', component: ModalContainer},
      Route {path: 'login',               component: LoginModal}
      Route {path: 'create-org',          component: CreateOrgModal}
      Route {path: 'send-invites/:orgid', component: SendInvitesModal}
      Route {path: 'select-org',          component: SelectOrgModal}
      Route {path: 'invite/:inviteid',    component: AcceptInviteModal}
      Route {path: 'signup/:tokenid',     component: SignUpModal}
    Route {path: ':orgid/', component: Shell},
      Route {name: 'workspace',  path: 'workspace',  component: WorkspaceScreen}
      Route {name: 'bigpicture', path: 'bigpicture', component: BigPictureScreen}
    Route {path: '*', component: NotFoundBanner}

React.render(router, document.body)
