<p align="center">
  <img src="public/img/icons/android-chrome-192x192.png">
</p>

# 💳 GamePay

GamePay is a simple payment app for board games involving some sort of payment.  
It makes use of WebNFC (Note: WebNFC is currently experimental and behind a flag on Chrome for Android, read more at https://web.dev/nfc/) to read cards with RFID tags. These cards with RFID tags can be registered on the app and given to each player in the game.

## Inspiration
Amidst the lockdown situation(due to COVID-19), me and my sister wanted to play Monopoly board game(after a long time). The thing that drives me away from playing these traditional board games is the **cleaning up and rearranging of the money after the game is over**. This made me wonder if there was a way to use a single card-based solution that can manage all the transactions during the game.

This made me build GamePay inspired by real-world mobile payment solutions that simply keeps track of the transactions during a game. The app was technically so simple, that the prototype took only a few hours!

## Demo
The gif shows how transactions are performed on GamePay during a game session.  
![](demos/demo.gif)


## Project stack
  - Vue.js
  - Tailwind CSS  
    I wanted to try out the Tailwind workflow, this small project seemed like a good starting point.

  This project is probably more suited as a native application since WebNFC support is experimental, but keeping it as a web app allowed me to prototype it quickly.
  

## FAQs
#### Why did you build this if you could just buy the Monopoly game for your phone?
That's because we wanted to go old school. Also, this app works for other board games involving money transactions.

#### There's a version of Monopoly that does this!
After I built this app, I found out there's a version of Monopoly that uses something like a credit card to manage transactions(How many versions of Monopoly are there? 😆)

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```


# License
GamePay is [MIT Licensed](https://github.com/blenderskool/game-pay/blob/master/LICENSE)