_        = require 'lodash'
React    = require 'react'
classSet = require 'common/util/classSet'
UrlAware = require 'ui/framework/mixins/UrlAware'
Icon     = React.createFactory(require 'ui/common/Icon')
Link     = React.createFactory(require 'ui/common/Link')

SidebarToggleButton = React.createClass {

  displayName: 'SidebarToggleButton'

  mixins: [UrlAware]

  render: ->

    isActive = @getCurrentUrl().getSidebar()

    classes = classSet [
      'button'
      'icon-only'
      'active' if isActive
    ]

    Link {className: classes, hotkey: 's', @getLinkUrl},
      Icon {name: if isActive then 'chevron-left' else 'chevron-right'}

  getLinkUrl: (currentUrl) ->
    currentUrl.toggleSidebar()

}

module.exports = SidebarToggleButton
