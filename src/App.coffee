React            = require 'react'
Router           = require 'react-router'
EventBusFactory  = require './EventBusFactory'
Shell            = require './shell/Shell'
LoginScreen      = require './screens/login/LoginScreen'
CreateUserScreen = require './screens/login/CreateUserScreen'
WorkspaceScreen  = require './screens/workspace/WorkspaceScreen'
BigPictureScreen = require './screens/bigpicture/BigPictureScreen'
StrategyScreen   = require './screens/strategy/StrategyScreen'
Route            = React.createFactory(Router.Route)

window.AppContext = {}
window.EventBus = EventBusFactory.create()

routes = [
  Route {name: 'login', key: 'login', path: 'login', handler: LoginScreen}
  Route {name: 'createuser', key: 'createuser', path: 'createuser', handler: CreateUserScreen}
  Route {name: 'shell', key: 'shell', path: ':orgid', handler: Shell}, [
    Route {name: 'workspace',  key: 'workspace',  handler: WorkspaceScreen}
    Route {name: 'bigpicture', key: 'bigpicture', handler: BigPictureScreen}
    Route {name: 'strategy',   key: 'strategy',   handler: StrategyScreen}
  ]
]

Router.run routes, Router.HistoryLocation, (handler) ->
  React.render(React.createElement(handler), document.body)
