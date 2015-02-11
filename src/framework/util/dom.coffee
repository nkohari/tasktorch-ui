exports.getData = getData = (node, key) ->
  # TODO: Support attribute lookups also for IE10
  node.dataset[key]

exports.getComputedStyle = getComputedStyle = (node) ->
  node.ownerDocument.defaultView.getComputedStyle(node, null)

exports.getPosition = getPosition = (node) ->
  doc = document.documentElement

  if node.getBoundingClientRect?
    rect = node.getBoundingClientRect()
  else
    rect = {top: 0, left: 0}

  return {
    top:  rect.top  + window.pageYOffset - doc.clientTop
    left: rect.left + window.pageXOffset - doc.clientLeft
  }

exports.getOffset = getOffset = (node) ->
  position = getPosition(node)
  parent = node.offsetParent

  if parent.nodeName isnt 'HTML'
    parentPosition = getPosition(parent)
  else
    parentPosition = {top: 0, left: 0}

  parentStyle = getComputedStyle(parent)
  parentPosition.top  += parseInt(parentStyle.borderTopWidth,  10)
  parentPosition.left += parseInt(parentStyle.borderLeftWidth, 10)

  nodeStyle = getComputedStyle(node)
  position.top  += parent.scrollTop
  position.left += parent.scrollLeft
  position.top  -= parseInt(nodeStyle.marginTop,  10)
  position.left -= parseInt(nodeStyle.marginLeft, 10)

  return {
    top:  position.top  - parentPosition.top
    left: position.left - parentPosition.left
  }

exports.getAncestors = getAncestors = (node) ->
  ancestors = []
  while ((node = node.parentNode) and node.nodeType != 9)
    ancestors.push(node) if node.nodeType == 1
  return ancestors
