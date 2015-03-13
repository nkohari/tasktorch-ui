_               = require 'lodash'
React           = require 'react'
CachedState     = require 'ui/framework/mixins/CachedState'
PropTypes       = require 'ui/framework/PropTypes'
Frame           = React.createFactory(require 'ui/common/Frame')
List            = React.createFactory(require 'ui/common/List')
KindSidebarItem = React.createFactory(require 'ui/screens/bigPicture/sidebar/KindSidebarItem')

ProgressSidebarPanel = React.createClass {

  displayName: 'ProgressSidebarPanel'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    kinds: cache('kindsByOrg').get(@props.currentOrg.id)
  }

  isReady: ->
    @state.kinds?

  render: ->

    items = _.map @state.kinds, (kind) =>
      KindSidebarItem {key: kind.id, kind}

    Frame {@isReady, className: 'kinds group'},
      Frame {className: 'header'}, 'Kinds'
      List {}, items
}

module.exports = ProgressSidebarPanel
