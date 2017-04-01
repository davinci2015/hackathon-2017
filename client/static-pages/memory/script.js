var BRAINYMO = BRAINYMO || {};

BRAINYMO.Game = (function() {

  var activeCards = [];
  var numOfCards;
  var cardHitCounter = 0;
  var card;
  var timer;
  var storage;

  /**
   * Method that will be invoked on card click
   */
  function handleCardClick() {

    var connection = $(this).data('connection');
    var hit;

    // Set card in active state
    // 'this' needs to be attached to context of card which is clicked
    if ( !$(this).hasClass('active') ) {
      $(this).addClass('active');
      activeCards.push($(this));

      // If user click on two cards then check
      if (activeCards.length == 2) {
        hit = checkActiveCards(activeCards);
      }

      if (hit === true) {
        cardHitCounter++;
        activeCards[0].add(activeCards[1]).unbind().addClass('wobble cursor-default');
        activeCards = [];

        // Game End
        if(cardHitCounter === (numOfCards / 2)) {
          // Reset active cards
          activeCards = [];
          // Reset counter
          cardHitCounter = 0;
          // End game
          endGame();
        }
      }
      // In case when user open more then 2 cards then automatically close first two
      else if(activeCards.length === 3) {
        for(var i = 0; i < activeCards.length - 1; i++) {
          activeCards[i].removeClass('active');
        }
        activeCards.splice(0, 2);
      }
    }
  }

  function endGame() {
    timer.stopTimer();

    // Retrieve current time
    var time = timer.retrieveTime();

    // Retrieve time from storage
    var timeFromStorage = storage.retrieveBestTime();

    // if there's already time saved in storage check if it's better than current one
    if (timeFromStorage != undefined && timeFromStorage != '') {
      // if current game time is better than one saved in store then save new one
      if (time.minutes < timeFromStorage.minutes || (time.minutes == timeFromStorage.minutes && time.seconds < timeFromStorage.seconds) ) {
        storage.setBestTime(time);
      }
    }
    // else if time is not saved in storage save it
    else {
      storage.setBestTime(time);
    }

    // Update best time
    timer.updateBestTime();
  }

  function checkActiveCards(connections) {
    return connections[0].data('connection') === connections[1].data('connection');
  }

  return function(config) {

    /**
     * Main method for game initialization
     */
    this.startGame = function() {
      card = new BRAINYMO.Card();
      timer = new BRAINYMO.Timer();
      storage = new BRAINYMO.Storage();
      numOfCards = config.cards.length;
      card.attachCardEvent(handleCardClick, config);
    };

    /**
     * After game initialization call this method in order to generate cards
     */
    this.generateCardSet = function() {
      // Generate new card set
      card.generateCards(config.cards);
      // Reset active cards array
      activeCards = [];

      // Reset timer
      timer.stopTimer();
      // Set timer
      timer.startTimer();
    };

    this.startGame();
  }

})();



BRAINYMO.Card = (function () {

  // Private variables
  var $cardsContainer = $('.cards-container');
  var $cardTemplate = $('#card-template');

  /**
   * Private method
   * Take card template from DOM and update it with card data
   * @param {Object} card - card object
   * @return {Object} template - jquery object
   */
  function prepareCardTemplate (card) {
    var template = $cardTemplate
      .clone()
      .removeAttr('id')
      .removeClass('hide')
      .attr('data-connection', card.connectionID);

    // If card has background image
    if (card.backImg != '' && card.backImg != undefined) {
      template.find('.back').css({
        'background': 'url(' + card.backImg + ') no-repeat center center',
        'background-size': 'cover'
      });
    }
    // Else if card has no background image but has text
    else if (card.backTxt != '' && card.backTxt != undefined) {
      template.find('.back > label').html(card.backTxt);
    }

    return template;
  }

  /**
   * Private method
   * Method for random shuffling array
   * @param {Object} cardsArray - array of card objects
   * @return {Object} returns random shuffled array
   */
  function shuffleCards(cardsArray) {
    var currentIndex = cardsArray.length, temporaryValue, randomIndex;

    while (0 !== currentIndex) {
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;
      temporaryValue = cardsArray[currentIndex];
      cardsArray[currentIndex] = cardsArray[randomIndex];
      cardsArray[randomIndex] = temporaryValue;
    }

    return cardsArray;
  }

  return function() {

    /**
     * Public method
     * Prepare all cards and insert them into DOM
     * Before inserting new set of cards method will erase all previous cards
     * @param {Object} cards - array of card objects
     */
    this.generateCards = function(cards) {
      var templates = [];
      var preparedTemplate;

      // Prepare every card and push it to array
      cards.forEach(function (card) {
        preparedTemplate = prepareCardTemplate(card);
        templates.push(preparedTemplate);
      });

      // Shuffle card array
      templates = shuffleCards(templates);

      // Hide and empty card container
      $cardsContainer.hide().empty();

      // Append all cards to cards container
      templates.forEach(function(card) {
        $cardsContainer.append(card);
      });

      // Show card container
      $cardsContainer.fadeIn('slow');
    };

    /**
     * Public method
     * Attach click event on every card
     * Before inserting new set of cards method will erase all previous cards
     * @param {Function} func - function that will be invoked on card click
     */
    this.attachCardEvent = function(func) {
      $cardsContainer.unbind().on('click', '.flip-container', function() {
        func.call(this);
      });
    }
  }

})();

BRAINYMO.Timer = (function() {

  var $timer = $('.timer');
  var $seconds = $timer.find('#seconds');
  var $minutes = $timer.find('#minutes');
  var $bestTimeContainer = $timer.find('.time');


  var minutes, seconds;

  function decorateNumber(value) {
    return value > 9 ? value : '0' + value;
  }

  return function() {
    var interval;
    var storage = new BRAINYMO.Storage();

    this.startTimer = function() {
      var sec = 0;
      var bestTime;

      // Set timer interval
      interval = setInterval( function() {
        seconds = ++sec % 60;
        minutes = parseInt(sec / 60, 10);
        $seconds.html(decorateNumber(seconds));
        $minutes.html(decorateNumber(minutes));
      }, 1000);

      // Show timer
      $timer.delay(1000).fadeIn();

      this.updateBestTime();
    };

    this.updateBestTime = function() {
      // Check if user have saved best game time
      bestTime = storage.retrieveBestTime();
      if(bestTime != undefined && bestTime != '') {
        $bestTimeContainer
          .find('#bestTime')
          .text(bestTime.minutes + ':' + bestTime.seconds)
          .end()
          .fadeIn();
      }
    };

    this.stopTimer = function() {
      clearInterval(interval);
    };

    this.retrieveTime = function() {
      return {
        minutes: decorateNumber(minutes),
        seconds: decorateNumber(seconds)
      }
    };
  }
})();


BRAINYMO.Storage = (function() {

  return function() {

    /**
     * Save best time to localStorage
     * key = 'bestTime'
     * @param {Object} time - object with keys: 'minutes', 'seconds'
     */
    this.setBestTime = function(time) {
      localStorage.setItem('bestTime', JSON.stringify(time));
    };

    /**
     * Retrieve best time from localStorage
     */
    this.retrieveBestTime = function() {
      return JSON.parse(localStorage.getItem('bestTime'));
    };

  }
})();



// Game init
$(function() {

  var brainymo = new BRAINYMO.Game({
    cards: [
      {
        backImg: 'https://s23.postimg.org/gmp35oru3/grunt.jpg',
        connectionID: 1
      },
      {
        backTxt: 'GRUNT',
        connectionID: 1
      },
      {
        backImg: 'https://s23.postimg.org/4q21yyfaj/react.jpg',
        connectionID: 2
      },
      {
        backTxt: 'REACT',
        connectionID: 2
      },
      {
        backImg: 'https://s23.postimg.org/raxfi9r6z/gsap.jpg',
        connectionID: 3
      },
      {
        backTxt: 'GSAP',
        connectionID: 3
      }
    ]
  });

  $('#btn-start').click(function() {
    brainymo.generateCardSet();
    $(this).text('Restart');
  });

});
