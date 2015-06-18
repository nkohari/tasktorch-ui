#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react/addons'
Navigator          = require 'ui/framework/mixins/Navigator'
PropTypes          = require 'ui/framework/PropTypes'
BigPicturePanel    = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
#--------------------------------------------------------------------------------

BigPicturePanelList = React.createClass {

  displayName: 'BigPicturePanelList'

  propTypes:
    panels: PropTypes.array

  mixins: [Navigator]

  render: ->

    panels = _.map @props.panels, (panelProps) =>
      props = _.extend {key: panelProps.id}, panelProps
      BigPicturePanel(props)

    CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide'},
      panels

}

module.exports = BigPicturePanelList
