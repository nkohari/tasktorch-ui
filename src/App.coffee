React  = require 'react'
Router = require 'react-router'
{Routes, Route} = Router

LoginScreen             = require './login/LoginScreen'
WorkspaceScreen         = require './workspace/WorkspaceScreen'
RedirectToLastWorkspace = require './common/RedirectToLastWorkspace'

routes = Routes {location: 'history'}, [
  Route {name: 'redirect',  path: '/',               handler: RedirectToLastWorkspace}
  Route {name: 'login',     path: 'login',           handler: LoginScreen}
  Route {name: 'workspace', path: ':organizationId', handler: WorkspaceScreen}
]

React.renderComponent(routes, document.body)
