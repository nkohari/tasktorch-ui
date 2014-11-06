React            = require 'react'
Router           = require 'react-router'
Routes           = React.createFactory(Router.Routes)
Route            = React.createFactory(Router.Route)
DefaultRoute     = React.createFactory(Router.DefaultRoute)
Shell            = React.createFactory(require './shell/Shell')
LoginScreen      = React.createFactory(require './screens/login/LoginScreen')
WorkspaceScreen  = React.createFactory(require './screens/workspace/WorkspaceScreen')
BigPictureScreen = React.createFactory(require './screens/bigpicture/BigPictureScreen')
PlanningScreen   = React.createFactory(require './screens/planning/PlanningScreen')

# TODO: DefaultRoute to redirect to last workspace
routes = Routes {location: 'history'}, [
  Route {name: 'login', key: 'login', path: 'login', handler: LoginScreen}
  Route {name: 'shell', key: 'shell', path: ':organizationId', handler: Shell}, [
    Route {name: 'workspace',  key: 'workspace',  handler: WorkspaceScreen}
    Route {name: 'bigpicture', key: 'bigpicture', handler: BigPictureScreen}
    Route {name: 'planning',   key: 'planning',   handler: PlanningScreen}
  ]
]

React.render(routes, document.body)
