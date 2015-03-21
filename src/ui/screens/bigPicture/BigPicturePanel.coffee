_              = require 'lodash'
React          = require 'react'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
KindPanelState = require 'ui/screens/bigPicture/panels/kind/KindPanelState'
TeamPanelState = require 'ui/screens/bigPicture/panels/team/TeamPanelState'
KindPanel      = React.createFactory(require 'ui/screens/bigPicture/panels/kind/KindPanel')
TeamPanel      = React.createFactory(require 'ui/screens/bigPicture/panels/team/TeamPanel')

BigPicturePanel = React.createClass {

  displayName: 'BigPicturePanel'

  propTypes:
    type: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      'data-itemid': @props.id
    }

    switch @props.type
      when TeamPanelState.type then TeamPanel(props)
      when KindPanelState.type then KindPanel(props)

}

module.exports = BigPicturePanel
