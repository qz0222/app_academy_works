const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game (plate_count) {
  this.piles = [[...Array(plate_count).keys()], [], []];
}

Game.prototype.promptMove = function () {
  console.log(this.piles);
  let piles = this.piles;
  let start;
  let end;
  let valid = false;

  reader.question("Select Start Tower:", function(answer) {
    console.log(answer);

    reader.question("Select End Tower:", function(answer2) {
      console.log(answer2);

      valid = (isValidMove(answer, answer2, piles));
      start = answer;
      end = answer2;
      reader.close();
      if (valid) {
        move(piles, start, end);
        return (piles);
      } else {
        console.log("invalid move!");
        return piles;
      }
    });
  });
};

function isValidMove(startTowerIndex, endTowerIndex, pile) {
  if (endTowerIndex >= pile.length || endTowerIndex < 0){ return false; }
  if (startTowerIndex >= pile.length || startTowerIndex < 0){ return false; }

  if (pile[startTowerIndex][0] > pile[endTowerIndex][0] || pile[startTowerIndex].length === 0){
    return false;
  }
  return true;
}

function move(piles, startTowerIndex, endTowerIndex) {
  piles[endTowerIndex].unshift(piles[startTowerIndex].shift());
}

function isWon(piles){
  if (piles[0].length > 0 ){ return false; }
  if (piles[1].length === 0 || piles[2].length === 0){ return true; }
  return false;
}

Game.prototype.run = function (completionCallback) {
  // console.log(this.piles[0].length);
  this.piles = this.promptMove();
  // console.log(this.piles);
  // if (isWon(this.piles)){
  //   completionCallback(this.piles);
  // } else {
  //   this.run();
  // }
};

let game = new Game(3);
game.run(function (arr) {
  console.log(" You win!: " + JSON.stringify(arr));
  reader.close();
});



// game.promptMove();

// console.log(isWon([[1,2,3],[],[]]));
// console.log(isWon([[1],[2, 3],[]]));
// console.log(isWon([[],[1, 2, 3],[]]));
// console.log(isWon([[],[],[1, 2, 3]]));
