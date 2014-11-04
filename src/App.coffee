React            = require 'react'
Router           = require 'react-router'
Routes           = React.createFactory(Router.Routes)
Route            = React.createFactory(Router.Route)
DefaultRoute     = React.createFactory(Router.DefaultRoute)
Shell            = React.createFactory(require './shell/Shell')
LoginScreen      = React.createFactory(require './login/LoginScreen')
WorkspaceScreen  = React.createFactory(require './workspace/WorkspaceScreen')
BigPictureScreen = React.createFactory(require './bigpicture/BigPictureScreen')

Wut = React.createFactory(React.createClass {
  render: ->
    React.DOM.div {}, ['derp']
})

# TODO: DefaultRoute to redirect to last workspace
routes = Routes {location: 'history'}, [
  Route {name: 'login', key: 'login', path: 'login', handler: LoginScreen}
  Route {name: 'shell', key: 'shell', path: ':organizationId', handler: Shell}, [
    Route {name: 'workspace',  key: 'workspace',  handler: WorkspaceScreen}
    Route {name: 'bigpicture', key: 'bigpicture', handler: BigPictureScreen}
    #DefaultRoute {handler: Wut}
  ]
]

React.render(routes, document.body)
