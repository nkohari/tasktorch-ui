#--------------------------------------------------------------------------------
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{a, div}  = React.DOM
#--------------------------------------------------------------------------------
require './WalkthroughProgress.styl'
#--------------------------------------------------------------------------------

WalkthroughProgress = React.createClass {

  displayName: 'WalkthroughProgress'

  propTypes:
    advance:     PropTypes.func
    currentStep: PropTypes.number
    totalSteps:  PropTypes.number

  render: ->

    progress  = @props.currentStep / @props.totalSteps
    rotation  = Math.floor(progress * 180)
    fillStyle = {transform: "rotate(#{rotation}deg)"}
    fixStyle  = {transform: "rotate(#{rotation * 2}deg)"}

    classes = classSet [
      'walkthrough-progress'
      'start' if @props.currentStep == 0
      'end'   if @props.currentStep == @props.totalSteps
    ]

    div {className: classes},
      a {className: 'walkthrough-progress-advance', onClick: @props.advance},
        Icon {name: if @props.currentStep == @props.totalSteps then 'complete' else 'forward'}
      div {className: 'walkthrough-progress-bar'},
        div {className: 'mask full', style: fillStyle},
          div {className: 'fill', style: fillStyle}
        div {className: 'mask half'},
          div {className: 'fill', style: fillStyle}
          div {className: 'fill fix', style: fixStyle}

}

module.exports = WalkthroughProgress
