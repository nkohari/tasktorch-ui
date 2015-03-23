_              = require 'lodash'
React          = require 'react'
CachedState    = require 'ui/framework/mixins/CachedState'
PropTypes      = require 'ui/framework/PropTypes'
Frame          = React.createFactory(require 'ui/common/Frame')
List           = React.createFactory(require 'ui/common/List')
KindDrawerItem = React.createFactory(require 'ui/screens/bigPicture/drawer/KindDrawerItem')

ProgressDrawerPanel = React.createClass {

  displayName: 'ProgressDrawerPanel'

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
      KindDrawerItem {key: kind.id, kind}

    Frame {@isReady, className: 'kinds group'},
      Frame {className: 'header'}, 'Kinds'
      List {}, items
}

module.exports = ProgressDrawerPanel
