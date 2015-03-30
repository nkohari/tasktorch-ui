_               = require 'lodash'
React           = require 'react'
CachedState     = require 'ui/framework/mixins/CachedState'
PropTypes       = require 'ui/framework/PropTypes'
Frame           = React.createFactory(require 'ui/common/Frame')
KindDrawerItem  = React.createFactory(require 'ui/screens/bigPicture/drawer/KindDrawerItem')
{div, span, ul} = React.DOM

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

    Frame {@isReady, className: 'drawer-group'},
      div {className: 'header'},
        span {className: 'title'}, 'Kinds'
      items
}

module.exports = ProgressDrawerPanel
