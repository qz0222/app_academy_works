
class Clock {
  constructor() {
    // 1. Create a Date object.
    let date = new Date();
    // 2. Store the hours, minutes, and seconds.
    // debugger
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    // 3. Call printTime.
    this.printTime();
    // 4. Schedule the tick at 1 second intervals.
    // while (true){
    // debugger
    setInterval( () => { this._tick(); }, 1000);
    // }
  }

  printTime() {
    // debugger
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // this.seconds += 1;
    this.seconds = Number(this.seconds) + 1;
    if (this.seconds > 59){
      this.minutes += 1;
      this.seconds = this.seconds % 60;
    }
    if (this.seconds < 10){
      this.seconds = ("0" + this.seconds);
    }

    if (this.minutes > 59){
      this.hours += 1;
      this.minutes = this.minutes % 60;
    }
    this.hours = this.hours % 24;
    // 2. Call printTime.
    this.printTime();
  }
}
// const clock = new Clock();


// const readline = require('readline');

// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Please enter a number:", function(answer) {
      const num = parseInt(answer);
      sum += num;
      console.log(`current sum is: ${sum}`);
      addNumbers(sum, numsLeft - 1, completionCallback);
    }
  );
  }
  if (numsLeft === 0){
    completionCallback(sum);

  }
}

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));


// absurdBubbleSort:

//helper method
function askIfGreaterThan(el1, el2, callback){
  reader.question(`Is ${el1} > ${el2}?`, function(answer) {
    if (answer === 'yes') {
      callback(true);
      // reader.close();
    } else {
      callback(false);
      // reader.close();
    }
  });
}


function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1){
    askIfGreaterThan(arr[i], arr[i + 1], isGreaterThan = function(value){
      if (value) {
        [arr[i], arr[i+1]] = [arr[i+1], arr[i]];
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    });
  }
  if (i === arr.length - 1){
    outerBubbleSortLoop(madeAnySwaps);
  }
}


function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps === true){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else {
      sortCompletionCallback(arr);
    }
    // Begin an inner loop if you made any swaps. Otherwise, call
    // `sortCompletionCallback`.
  }
  outerBubbleSortLoop(true);

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}


// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });




// Function Calling

Function.prototype.myBind = function(context) {
  return () => { this.apply(context); };
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
};

const lamp = new Lamp();

turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"
