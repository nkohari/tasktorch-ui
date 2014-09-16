React = require 'react'
{Routes, Route} = require 'react-router'

WorkspaceScreen = require './screens/WorkspaceScreen'

router = Routes {}, [
  Route {name: '/', handler: WorkspaceScreen}
]

React.renderComponent(router, document.body)
