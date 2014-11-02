React  = require 'react'
Router = require 'react-router'
Routes = React.createFactory(Router.Routes)
Route  = React.createFactory(Router.Route)

LoginScreen             = React.createFactory(require './login/LoginScreen')
WorkspaceScreen         = React.createFactory(require './workspace/WorkspaceScreen')
RedirectToLastWorkspace = React.createFactory(require './common/RedirectToLastWorkspace')

routes = Routes {location: 'history'}, [
  Route {name: 'redirect',  key: 'redirect',  path: '/',               handler: RedirectToLastWorkspace}
  Route {name: 'login',     key: 'login',     path: 'login',           handler: LoginScreen}
  Route {name: 'workspace', key: 'workspace', path: ':organizationId', handler: WorkspaceScreen}
]

React.render(routes, document.body)
