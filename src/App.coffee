_                  = require 'lodash'
cookies            = require 'cookies-js'
React              = require 'react/addons'
Router             = require 'react-router'
Environment        = require './Environment'
Shell              = require 'ui/shell/Shell'
LoginInterstitial  = require 'ui/interstitials/login/LoginInterstitial'
InviteInterstitial = require 'ui/interstitials/invite/InviteInterstitial'
WorkspaceScreen    = require 'ui/screens/workspace/WorkspaceScreen'
BigPictureScreen   = require 'ui/screens/bigPicture/BigPictureScreen'
StrategyScreen     = require 'ui/screens/strategy/StrategyScreen'
KnowledgeScreen    = require 'ui/screens/knowledge/KnowledgeScreen'
Route              = React.createFactory(Router.Route)

window.Environment = environment = new Environment()
window.Perf = React.addons.Perf

routes = [
  Route {name: 'login', key: 'login', path: 'login', handler: LoginInterstitial}
  Route {name: 'invite', key: 'invite', path: 'invite', handler: InviteInterstitial}
  Route {name: 'shell', key: 'shell', path: ':orgid', handler: Shell}, [
    Route {name: 'workspace',  key: 'workspace',  handler: WorkspaceScreen}
    Route {name: 'bigpicture', key: 'bigpicture', handler: BigPictureScreen}
    Route {name: 'strategy',   key: 'strategy',   handler: StrategyScreen}
    Route {name: 'knowledge',  key: 'knowledge',  handler: KnowledgeScreen}
  ]
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

  React.render(element, document.body)
