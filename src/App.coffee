React = require 'react'
{Routes, Route} = require 'react-router'

LoginScreen     = require './screens/LoginScreen'
WorkspaceScreen = require './screens/WorkspaceScreen'

router = Routes {}, [
  Route {name: 'login',     path: '/login',           handler: LoginScreen}
  Route {name: 'workspace', path: '/:organizationId', handler: WorkspaceScreen}
]

React.renderComponent(router, document.body)
