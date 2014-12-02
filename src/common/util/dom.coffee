exports.getComputedStyle = getComputedStyle = (node) ->
  node.ownerDocument.defaultView.getComputedStyle(node, null)

exports.getOffset = getOffset = (node) ->
  doc = document.documentElement

  if node.getBoundingClientRect?
    rect = node.getBoundingClientRect()
  else
    rect = {top: 0, left: 0}

  return {
    top:  rect.top  + window.pageYOffset - doc.clientTop
    left: rect.left + window.pageXOffset - doc.clientLeft
  }

exports.getRelativePosition = getRelativePosition = (node, parent) ->
  offset = getOffset(node)

  if parent.nodeName isnt 'HTML'
    parentOffset = getOffset(parent)
  else
    parentOffset = {top: 0, left: 0}

  parentStyle = getComputedStyle(parent)
  parentOffset.top  += parseInt(parentStyle.borderTopWidth,  10)
  parentOffset.left += parseInt(parentStyle.borderLeftWidth, 10)

  nodeStyle = getComputedStyle(node)
  offset.top  += parent.scrollTop
  offset.left += parent.scrollLeft
  offset.top  -= parseInt(nodeStyle.marginTop,  10)
  offset.left -= parseInt(nodeStyle.marginLeft, 10)

  return {
    top:  offset.top  - parentOffset.top
    left: offset.left - parentOffset.left
  }
