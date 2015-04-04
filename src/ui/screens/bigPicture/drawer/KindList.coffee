_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
KindDrawerItem  = React.createFactory(require 'ui/screens/bigPicture/drawer/KindDrawerItem')
{div, span, ul} = React.DOM

KindList = React.createClass {

  displayName: 'KindList'

  propTypes:
    kinds: PropTypes.arrayOf(PropTypes.Kind)

  render: ->

    items = _.map @props.kinds, (kind) =>
      KindDrawerItem {key: kind.id, kind}

    div {className: 'drawer-group'},
      div {className: 'header'},
        span {className: 'title'}, 'Kinds of Work'
      items

}

module.exports = KindList
