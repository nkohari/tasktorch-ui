React            = require 'react'
Router           = require 'react-router'
Routes           = React.createFactory(Router.Routes)
Route            = React.createFactory(Router.Route)
DefaultRoute     = React.createFactory(Router.DefaultRoute)
Shell            = React.createFactory(require './shell/Shell')
LoginScreen      = React.createFactory(require './screens/login/LoginScreen')
CreateUserScreen = React.createFactory(require './screens/login/CreateUserScreen')
WorkspaceScreen  = React.createFactory(require './screens/workspace/WorkspaceScreen')
BigPictureScreen = React.createFactory(require './screens/bigpicture/BigPictureScreen')
PlanningScreen   = React.createFactory(require './screens/planning/PlanningScreen')
EventBusFactory  = require './EventBusFactory'

window.AppContext = {}
window.EventBus = EventBusFactory.create()

# TODO: DefaultRoute to redirect to last workspace
routes = Routes {location: 'history'}, [
  Route {name: 'login', key: 'login', path: 'login', handler: LoginScreen}
  Route {name: 'createuser', key: 'createuser', path: 'createuser', handler: CreateUserScreen}
  Route {name: 'shell', key: 'shell', path: ':orgid', handler: Shell}, [
    Route {name: 'workspace',  key: 'workspace',  handler: WorkspaceScreen}
    Route {name: 'bigpicture', key: 'bigpicture', handler: BigPictureScreen}
    Route {name: 'planning',   key: 'planning',   handler: PlanningScreen}
  ]
]

React.render(routes, document.body)
