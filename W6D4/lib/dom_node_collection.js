class DOMNodeCollection {
  constructor(array) {
    this.htmlArray = array
  }

  html(string) {
    if (string === undefined) {
      return this.htmlArray[0].innerHTML;
    } else {
      this.htmlArray.forEach (function(htmlElement) {
        htmlElement.innerHTML = string;
      })
    }
  }

  empty(){
    this.html("");
  }

  isaDOM(inputObj) {
    return (inputObj instanceof DOMNodeCollection);
  }

  append(inputObj){
    this.htmlArray.forEach ((htmlElement)=> {
      if (typeof inputObj === "string") {
        htmlElement.innerHTML += inputObj;
      } else if (inputObj instanceof HTMLElement) {
        htmlElement.innerHTML += inputObj.outerHTML;
      // } else if (this.isaDOM(inputObj)) {
      //   const fakeCopy = inputObj.htmlArray.slice();
      //   fakeCopy.forEach(function(inputEl) {
      //     htmlElement.innerHTML += inputEl.outerHTML;
      //   }) THIS WILL DESTROY YOUR COMPUTER
      }
    })
  }

  attr(key,val){
    if ( val === undefined ){
      return this.htmlArray[0].getAttribute(key)
    } else {
      this.htmlArray.forEach (function(htmlElement) {
        htmlElement.setAttribute(key, val);
      })
    }
  }

  addClass(classname){
    this.htmlArray.forEach (function(htmlElement) {
      let currentClassName = htmlElement.className;
      if ( currentClassName==="" ){
        htmlElement.className = classname;
      } else {
        if (currentClassName.includes(classname) === false){
          htmlElement.className += (' '+classname);
        }
      }
    })
  }

  removeClass(classname){
    this.htmlArray.forEach (function(htmlElement) {
      htmlElement.className = htmlElement.className.replace((" " + classname), "");
      htmlElement.className = htmlElement.className.replace((classname+" "), "");
    })
  }

  children(){
    let allChildren = [];
    this.htmlArray.forEach (function(htmlElement) {
      htmlElement.childNodes.forEach ( function(childnode){
        if (childnode.nodeType === 1){ allChildren.push(childnode); }
      })
    })
    return allChildren;
  }

  parent(){
    let allParents = [];
    this.htmlArray.forEach (function(htmlElement) {
      if (!allParents.includes(htmlElement.parentNode)){
        allParents.push(htmlElement.parentNode);
      }
    })
    return allParents;
  }

  find(selector) {
    let result = [];
    this.htmlArray.forEach (function(htmlElement){
      let finded = htmlElement.querySelectorAll(selector);
      if (finded.length > 0){
        result = result.concat(Array.from(finded));
      }
    })
    return result;
  }

  remove(){
    this.htmlArray.forEach (function(htmlElement){
      htmlElement.parentNode.removeChild(htmlElement);
    })
    this.htmlArray = [];
  }

  on(eventTarget, callback) {
    this.htmlArray.forEach (function(htmlElement){
      htmlElement['callback2'] = []
      htmlElement['callback2'].push(callback);
      htmlElement.addEventListener(eventTarget, htmlElement['callback2'][0]);
    })
  }

  off(eventTarget) {
    this.htmlArray.forEach (function(htmlElement){
      htmlElement.removeEventListener(eventTarget, htmlElement['callback2'][0]);
      // htmlElement.removeAttribute(eventTarget);
      // ????? HOW DO YOU PASS THE CALLBACKKKKKK ?????????????
    });
  }
}

module.exports = DOMNodeCollection;
