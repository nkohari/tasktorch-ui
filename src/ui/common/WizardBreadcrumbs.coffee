_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
PropTypes      = require 'ui/framework/PropTypes'
{span, li, ul} = React.DOM

WizardBreadcrumbs = React.createClass {

  displayName: 'WizardBreadcrumbs'

  propTypes:
    currentPage: PropTypes.number
    pages:       PropTypes.arrayOf(PropTypes.node)
    setPage:     PropTypes.func

  render: ->

    items = _.map @props.pages, (child, index) =>
      return unless child?
      classes = classSet [
        'breadcrumb'
        'active' if index == @props.currentPage
      ]
      li {className: classes, onClick: @onBreadcrumbClicked.bind(this, index)},
        span {className: 'breadcrumb-number'}, index + 1
        span {className: 'breadcrumb-title'}, child.props?.title

    ul {className: 'breadcrumbs'}, items

  onBreadcrumbClicked: (index) ->
    @props.setPage(index)

}

module.exports = WizardBreadcrumbs
