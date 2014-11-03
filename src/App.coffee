React  = require 'react'
Router = require 'react-router'
Routes = React.createFactory(Router.Routes)
Route  = React.createFactory(Router.Route)

Shell            = React.createFactory(require './shell/Shell')
LoginScreen      = React.createFactory(require './login/LoginScreen')
WorkspaceScreen  = React.createFactory(require './workspace/WorkspaceScreen')
BigPictureScreen = React.createFactory(require './bigpicture/BigPictureScreen')

# TODO: DefaultRoute to redirect to last workspace
routes = Routes {location: 'history'}, [
  Route {name: 'login', key: 'login', path: 'login', handler: LoginScreen}
  Route {name: 'shell', key: 'shell', path: ':organizationId', handler: Shell}, [
    Route {name: 'workspace',  key: 'workspace',  path: 'workspace',  handler: WorkspaceScreen}
    Route {name: 'bigpicture', key: 'bigpicture', path: 'bigpicture', handler: BigPictureScreen}
  ]
]

React.render(routes, document.body)
