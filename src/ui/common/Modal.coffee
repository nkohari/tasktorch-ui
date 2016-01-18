#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
mergeProps       = require 'common/util/mergeProps'
PropTypes        = require 'ui/framework/PropTypes'
{div, img, span} = React.DOM
#--------------------------------------------------------------------------------
require './Modal.styl'
#--------------------------------------------------------------------------------

Modal = React.createClass {

  displayName: 'Modal'

  propTypes:
    title: PropTypes.string

  componentDidMount: ->
    document.title = "TaskTorch | #{@props.title}"

  render: ->

    props = mergeProps _.omit(@props, 'form', 'title', 'renderMessage'), {
      className: 'modal'
    }

    div props,
      div {className: 'modal-splash'},
        img {className: 'logo', src: require('img/logo.png')}
        div {className: 'brand'},
          span {className: 'word-one'}, 'Task'
          span {className: 'word-two'}, 'Torch'
      div {className: 'modal-content'},
        @props.children

}

module.exports = Modal
