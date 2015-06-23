#--------------------------------------------------------------------------------
_                 = require 'lodash'
cookies           = require 'cookies-js'
React             = require 'react'
Router            = require 'react-router'
Analytics         = require 'common/Analytics'
Environment       = require './Environment'
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
StrategyScreen    = require 'ui/screens/strategy/StrategyScreen'
KnowledgeScreen   = require 'ui/screens/knowledge/KnowledgeScreen'
Route             = React.createFactory(Router.Route)
NotFoundRoute     = React.createFactory(Router.NotFoundRoute)
#--------------------------------------------------------------------------------
require './App.styl'
#--------------------------------------------------------------------------------

window.debug = require('common/util/debug')
window.Environment = environment = new Environment()

routes = [

  Route {key: 'modal', path: 'x', handler: ModalContainer},
    Route {name: 'login',        key: 'login',        path: 'login',               handler: LoginModal}
    Route {name: 'create-org',   key: 'create-org',   path: 'create-org',          handler: CreateOrgModal}
    Route {name: 'send-invites', key: 'send-invites', path: 'send-invites/:orgid', handler: SendInvitesModal}
    Route {name: 'select-org',   key: 'select-org',   path: 'select-org',          handler: SelectOrgModal}
    Route {name: 'invite',       key: 'invite',       path: 'invite/:inviteid',    handler: AcceptInviteModal}
    Route {name: 'signup',       key: 'signup',       path: 'signup/:tokenid',     handler: SignUpModal}

  Route {name: 'shell', key: 'shell', path: ':orgid', handler: Shell},
    Route {name: 'workspace',    key: 'workspace',    path: 'workspace',        handler: WorkspaceScreen}
    Route {name: 'bigpicture',   key: 'bigpicture',   path: 'bigpicture',       handler: BigPictureScreen}
    Route {name: 'strategy',     key: 'strategy',     path: 'strategy',         handler: StrategyScreen}
    Route {name: 'knowledge',    key: 'knowledge',    path: 'knowledge',        handler: KnowledgeScreen}

  NotFoundRoute {handler: NotFoundBanner}

]

Router.run routes, Router.HistoryLocation, (handler, state) ->

  environment.orgid  = state.params.orgid
  environment.userid = cookies.get('tt-userid')

  url = _.extend {}, state, {
    screen: state.routes[1]?.name
  }

  element = React.createElement(handler, {
    orgid:  environment.orgid
    userid: environment.userid
    url:    url
  })

  Analytics.update()
  React.render(element, document.body)
