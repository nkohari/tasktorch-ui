React            = require 'react'
Router           = require 'react-router'
EventBusFactory  = require './EventBusFactory'
Shell            = require './ui/shell/Shell'
LoginScreen      = require './ui/screens/login/LoginScreen'
CreateUserScreen = require './ui/screens/createUser/CreateUserScreen'
WorkspaceScreen  = require './ui/screens/workspace/WorkspaceScreen'
BigPictureScreen = require './ui/screens/bigPicture/BigPictureScreen'
StrategyScreen   = require './ui/screens/strategy/StrategyScreen'
Route            = React.createFactory(Router.Route)

window.AppContext = {}
window.EventBus = EventBusFactory.create()

unless process.env.NODE_ENV == 'production'
  window.onerror = (message, file, line, col, error) ->
    console.error(message, "from", error.stack)

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
