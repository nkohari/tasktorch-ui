_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PanelKey        = require 'ui/framework/PanelKey'
PropTypes       = require 'ui/framework/PropTypes'
UrlAware        = require 'ui/framework/mixins/UrlAware'
Icon            = React.createFactory(require 'ui/common/Icon')
Link            = React.createFactory(require 'ui/common/Link')
ListItem        = React.createFactory(require 'ui/common/ListItem')
KindColorMarker = React.createFactory(require 'ui/common/KindColorMarker')
{a, span}       = React.DOM

KindSidebarItem = React.createClass {

  displayName: 'KindSidebarItem'

  propTypes:
    kind: PropTypes.Kind

  mixins: [UrlAware]

  render: ->

    ListItem {className: 'sidebar-item'},
      a {},
        KindColorMarker {kind: @props.kind}
        span {className: 'name'}, @props.kind.name

}

module.exports = KindSidebarItem
