exports.getOffset = getOffset = (node) ->
  doc = document.documentElement

  if node.getBoundingClientRect?
    box = node.getBoundingClientRect()
  else
    box = {top: 0, left: 0}

  return {
    top:  box.top  + window.pageYOffset + doc.clientTop
    left: box.left + window.pageXOffset + doc.clientLeft
  }

exports.getRelativePosition = getRelativePosition = (node, parent) ->
  offset = getOffset(node)

  if parent.nodeName isnt 'HTML'
    parentOffset = getOffset(parent)
  else
    parentOffset = {top: 0, left: 0}

  parentOffset.top  += parseInt(getComputedStyles(parent).borderTopWidth,  10)
  parentOffset.left += parseInt(getComputedStyles(parent).borderLeftWidth, 10)

  offset.top  -= parseInt(getComputedStyles(node).marginTop,  10)
  offset.left -= parseInt(getComputedStyles(node).marginLeft, 10)

  return {
    top:  offset.top - parentOffset.top
    left: offset.left - parentOffset.left
  }
