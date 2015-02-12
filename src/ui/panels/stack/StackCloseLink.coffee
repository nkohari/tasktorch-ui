_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

StackCloseLink = React.createClass {

  displayName: 'StackCloseLink'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Router.State]

  render: ->

    url = new Url(this)
    url.removeStack(@props.stack.id)

    Link url.makeLinkProps(className: 'close'),
      Icon {name: 'close'}

}

module.exports = StackCloseLink
