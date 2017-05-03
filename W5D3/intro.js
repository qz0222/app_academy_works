function my_uniq(array) {
  let result = [];
  array.forEach(function(el) {
    if(!result.includes(el)) {
      result.push(el);
    }
  });

  return result;
}

// console.log(my_uniq([1,1,5,3,4,6,6]));

function two_sum(array) {
  let test = {};
  let result = [];
  for(let i = 0; i < array.length; i++) {
    // debugger
    if(test[array[i]] >= 0) {
      result.push([test[array[i]], i]);
    } else {
      test[-1 * array[i]] = i;
    }
  }

  return result;
}



// console.log(two_sum([-1, 0, 2, -2, 1]));


function myTranspose(array) {
  let result = [];
  array.forEach(function() {
    result.push([]);
  });
  for(let i = 0; i< array.length ; i++) {
    for(let j = 0; j < array[i].length ; j++) {
      result[j][i] = array[i][j];
    }
  }
  return result;
}

// rows = [
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ];

// console.log(my_transpose(rows));
Array.prototype.myEach = function(callback){
  for(let i = 0; i < this.length; i++){
    callback(this[i]);
  }
};

// [1, 2, 3, 4, 5].my_each( function(el) {
//   console.log(el * 2);
// });

Array.prototype.myMap = function(callback){
  let result = [];
  this.my_each( function(el) {
    result.push(callback(el));
  });
  return result;
};

// let b = [1,2,3,4,5].my_map(function(el){
//   return el * 2;
// });
// console.log(b);
Array.prototype.myInject = function(accum, callback){
  let array = this;
  if (arguments.length === 1) {
    callback = accum;
    accum = array[0];
    array = array.slice(1);
  }
  let result = accum;
  array.myEach( function(el) {
    result = callback(result, el);
  });
  return result;
};

// let test = [1,2,3,4].myInject(function(accu, el){
  // return accu + el;
// });
// console.log(test);
Array.prototype.mySelect = function(callback){
  let result = [];
  this.myEach( function(el) {
    if(callback(el)){
      result.push(el);
    }
  });
  return result;
};


// console.log(a);
// Hash.prototype.myEach = Array.prototype.myEach;

Array.prototype.myCount = function(callback){
  let result = 0;
  this.myEach( function(el) {
    if(callback(el)){
      result += 1;
    }
  });
  return result;
};
//
// let a = [2, 4, 6, 8, 10].myCount( function(el) {
//   return el < 5;
// });
//
// console.log(a);

Array.prototype.myInclude = function(num){
  let result = false;
  this.myEach( function(el) {
    if(el === num){
      result = true;
      return;
    }
  });
  return result;
};

// console.log([1,2,3,4,5].myInclude(99));

Array.prototype.myAny = function(callback){
  let result = false;
  this.myEach( function(el) {
    if(callback(el)){
      result = true;
      return;
    }
  });
  return result;
};

// console.log([1,2,3,4,5].myAny(function(el) {
//   return el % 2 === 0;
// })
// );

function bubbleSort(input) {
  let array = [];
  input.myEach(function(el){
    array.push(el);
  });
  for(let i = 0; i < array.length; i++){
    for(let j = 0 ; j < array.length - i -1; j++) {
      if (array[j] > array[j+1]){
        [array[j], array[j+1]] = [array[j+1], array[j]];
      }

    }
  }
  return array;
}

// console.log(bubbleSort([3,5,4,6,7,1]));

function subStrings(str){
  let result = [];
  for (let i = 0; i < str.length; i++) {
    for(let j = i+1; j <= str.length; j++) {
      result.push(str.slice(i,j));
    }
  }
  return result;
}

// console.log(subStrings('cat'));

  function range(start, end){
    if( end < start ) {
      return [];
    }
    return [start].concat(range(start + 1, end));
  }


function exp1(base, e) {
  if (e === 0){ return 1; }
  return base * exp1(base, e-1);
}

function exp2(base, e) {
  if (e === 0){ return 1; }
  if (e % 2 === 0){
    return exp2(base, e / 2) * exp2(base, e / 2);
  }else {
    return base * (exp2(base, (e - 1) / 2) * (exp2(base, (e - 1) / 2) ));
  }
}

function fib(n) {
  if (n === 1 ){
    return [1];
  }
  if (n === 2 ){
    return [1,1];
  }
  let prev = fib(n-1);
  let num = prev[prev.length - 1] + prev[prev.length - 2];
  return prev.concat([num]);
}

function bsearch(array, target) {
  if (array.length === 0 ) {
    return null;
  }
  const mid = Math.floor(array.length/2);
  if (array[mid] === target){
    return mid;
  }

  if ( target < array[mid] ) {
    let left = array.slice(0, mid);
    return bsearch(left, target);
  } else {
    let right = array.slice(mid + 1, array.length);
    let right_result = bsearch(right, target);
    if ( right_result === null){ return null; }else {
      return mid + 1 + right_result;
    }
  }

}

// console.log(bsearch([1, 3, 4, 5, 9], 5));


function makeChange(target, coins){
  if (target === 0  ){
    let a = [];
    return a;}
  let minimumNumOfCoins;
  let result = [];
  let currentNumberOfCoins;
  coins.forEach(function(coin){
    if(target >= coin){
      prev_result = makeChange(target - coin, coins);
      currentNumberOfCoins = 1 + prev_result.length;
      if (minimumNumOfCoins === undefined || minimumNumOfCoins > currentNumberOfCoins){
        minimumNumOfCoins = currentNumberOfCoins;
        result = [coin].concat(prev_result);
      }
      // result.push([coin].concat(prev_result));
    }

  });
  return result;

}
