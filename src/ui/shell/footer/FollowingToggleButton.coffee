_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
Url       = require 'framework/Url'
PropTypes = require 'framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
{span}    = React.DOM

FollowingToggleButton = React.createClass {

  displayName: 'FollowingToggleButton'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  mixins: [Router.State]

  render: ->

    url = new Url(this)

    classes = ['button']
    classes.push('active') if url.isFollowingActive()

    url.screen = 'workspace'
    url.toggleFollowing()

    props = url.makeLinkProps {
      className: classes.join(' ')
      hotkey:    'f'
    }

    Link props,
      Icon {name: 'follow'}
      span {className: 'count'}, @props.cards.length

}

module.exports = FollowingToggleButton
