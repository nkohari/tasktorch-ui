React    = require 'react'
Flux     = require '../../mixins/Flux'
Panel    = React.createFactory(require '../../common/Panel')
TeamList = React.createFactory(require './TeamList')

BigPictureSidebar = React.createClass {

  displayName: 'BigPictureSidebar'

  mixins: [Flux()]

  render: ->

    Panel {panelTitle: 'Teams', className: 'big-picture sidebar'}, [
      TeamList {key: 'team-list'}
    ]

}

module.exports = BigPictureSidebar
