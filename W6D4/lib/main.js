let DOMNodeCollection = require('./dom_node_collection.js');

Window.prototype.$l = function (selector){
  if (selector instanceof HTMLElement ) {
    let nodeArray = Array.from(selector);
    return new DOMNodeCollection(nodeArray);
  } else {
    let nodeList = document.querySelectorAll(selector);
    let nodeArray = Array.from(nodeList);
    return new DOMNodeCollection(nodeArray);
  }
};
