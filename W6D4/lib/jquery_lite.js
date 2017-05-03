/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

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


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

let DOMNodeCollection = __webpack_require__(0);

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


/***/ })
/******/ ]);