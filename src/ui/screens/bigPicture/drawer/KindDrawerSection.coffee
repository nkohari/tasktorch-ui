#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
DrawerSection  = React.createFactory(require 'ui/common/DrawerSection')
KindDrawerItem = React.createFactory(require 'ui/screens/bigPicture/drawer/KindDrawerItem')
#--------------------------------------------------------------------------------

KindDrawerSection = React.createClass {

  displayName: 'KindDrawerSection'

  propTypes:
    kinds: PropTypes.arrayOf(PropTypes.Kind)

  render: ->

    items = _.map @props.kinds, (kind) =>
      KindDrawerItem {key: kind.id, kind}

    DrawerSection {className: 'kind-section', title: 'By Kind'},
      items

}

module.exports = KindDrawerSection
