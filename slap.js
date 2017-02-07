
/* global Deck */

var prefix = Deck.prefix

var transform = prefix('transform')

var translate = Deck.translate

var $container = document.getElementById('container')

var deck = Deck()

function play() {
  deck.shuffle()
  var table = [[],[],[],[]]
  var p0Cards = [[],[],[],[],[]]
  var p1Cards = [[],[],[],[],[]]
  var plan = [
    [0,1],
    [1,0],
    [2,0],
    [3,0],
    [4,0],
    [1,1],
    [2,0],
    [3,0],
    [4,0],
    [2,1],
    [3,0],
    [4,0],
    [3,1],
    [4,0],
    [4,1],
  ]
  deck.queue(function (next) {
    deck.cards.forEach(function (card, i) {
      var theX
      var theY
      var yShift = 0
      card.setSide('back')
      if (card.pos < 15) {
        if (plan[card.pos][1]) {
          setTimeout(function () {
            deck.cards[i].setSide('front')
          }, 5200)
        } 
        theX = 4 - plan[card.pos][0]
        theY = 0
        p0Cards[theX].push(i)
        yShift = p0Cards[theX].length * -10
      } else if (card.pos < 30) {
        if (plan[card.pos-15][1]) {
          setTimeout(function () {
            deck.cards[i].setSide('front')
          }, 5200)
        } 
        theX = plan[card.pos-15][0]
        theY = 2
        p1Cards[theX].push(i)
        yShift = p1Cards[theX].length * 10
      } else if (card.pos < 40) {
        table[0].push(i)
        theX = 4
        theY = 1
      } else if (card.pos < 50){
        table[3].push(i)
        theX = 0
        theY = 1
      } else if (card.pos == 50) {
        setTimeout(function () {
          deck.cards[i].setSide('front')
        }, 9000)
        table[1].push(i)
        theX = 1
        theY = 1
      } else {
        setTimeout(function () {
          deck.cards[i].setSide('front')
        }, 9000)
        table[2].push(i)
        theX = 3
        theY = 1
      } 
    
      
      
      card.animateTo({
        delay: 500 + (52 - card.pos) * 75,
        duration: 500 + card.pos * 27,
    		ease: 'quartOut',
        x: ((theX/4) * window.innerWidth - window.innerWidth / 2) * .7,
        y: (((theY/2) * window.innerHeight - window.innerHeight / 2) *.6) + yShift,
        
      })
      card.enableDragging()
      card.enableFlipping()
    })
    console.log(p0Cards,p1Cards,table)
    next()
  }) 
}

deck.mount($container)

deck.intro()
deck.flip()
deck.sort(true) // sort reversed
deck.bysuit()
deck.flip()
deck.fan()
deck.sort()
deck.fan()
play()
