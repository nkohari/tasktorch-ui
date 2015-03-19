_                  = require 'lodash'
React              = require 'react/addons'
Navigator          = require 'ui/framework/mixins/Navigator'
PropTypes          = require 'ui/framework/PropTypes'
BigPicturePanel    = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

BigPicturePanelList = React.createClass {

  displayName: 'BigPicturePanelList'

  propTypes:
    panels:      PropTypes.array
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [Navigator]

  render: ->

    panels = _.map @props.panels, (panel) =>
      props = _.extend {key: panel.id, currentUser: @props.currentUser, currentOrg: @props.currentOrg}, panel
      BigPicturePanel(props)

    #CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide'},
    div {className: 'content'},
      panels

}

module.exports = BigPicturePanelList
