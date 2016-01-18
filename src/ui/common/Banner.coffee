#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
mergeProps       = require 'common/util/mergeProps'
PropTypes        = require 'ui/framework/PropTypes'
{div, img, span} = React.DOM
#--------------------------------------------------------------------------------
require './Banner.styl'
#--------------------------------------------------------------------------------

Banner = React.createClass {

  displayName: 'Banner'

  propTypes:
    title: PropTypes.string

  componentDidMount: ->
    document.title = "TaskTorch | #{@props.title}"

  render: ->

    props = mergeProps _.omit(@props, 'title'), {
      className: 'banner'
    }

    div {className: 'banner-container'},
      div props,
        div {className: 'banner-splash'},
          img {className: 'logo', src: require('img/logo.png')}
          div {className: 'brand'},
            span {className: 'word-one'}, 'Task'
            span {className: 'word-two'}, 'Torch'
        div {className: 'banner-content'},
          @props.children

}

module.exports = Banner
