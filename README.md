# README

Heroku Link for deployed app: https://gentle-stream-27906.herokuapp.com/

Github repo: https://github.com/Nwilnai/Team9

Trello Link: https://trello.com/b/fLieZouT/capstone-team-9

Continuous Integration is working, and our workflow file can be found in .github/workflows/CI.yml. Our tests run automatically after any pushes to master or any time a PR is made/updated. Heroku does not pull the changes until the tests have passed.

Functionality: Users can sign up, sign in and sign out of their accounts. When users sign up, they get 500 tokens. Once logged in, users can play a game of blackjack against the computerized dealer. Within each game of blackjack, users can choose an amount of tokens to bet (from 10 to their total # of tokens) and then users can decide to either ‘hit’ or ‘stand’ depending on the cards that they have received, as well as the dealer's single showing card. Users can also access their profile page, which contains their email, the number of tokens they have accumulated, and an option to update their sign-up information. If a user runs out of tokens, they can visit our store to restock! In our store, we gift 100 tokens to any user with less than 100 tokens. If a player begins a game with an insufficient amount of tokens, a link to the store will appear on the betting page. Users can also visit the leaderboard page which shows all users, and their rank by total amount of tokens. If users are new to blackjack, they can view the rules of blackjack in our about page, as well as learn some strategies for becoming the ultimate blackjack guru! If users encounter any problems, they can visit the help page, where they can use our mail form to easily shoot us an email!

Easy-to-miss functionality: Our hit and stand buttons ensure that a user can only submit a hit or stand action once, preventing the user from hitting multiple times (which would cause them to have many cards by the time the page reloaded). Our game logic ensures that reloading the page after a win (or loss) will not continuously reward users for the same victory. 

URL Patterns:
- /			        Home page
- /users			Users page (lists all users)
- /users/1		        Profile page (gets user 1)
- /users/1/edit	Settings page (edits user 1)
- /login			Login page (displays user login prompt)
- /logout			Logout page
- /leaderboard                  Leaderboard page (based on # of tokens)
- /help			        Help page
- /about			About page
- /admin                        RailsAdmin
- /bet                          Betting page, lets user bet before starting a game 
- /games/new	                New game session directs to a new game
- /games/1		        Game 1’s show page, where blackjack game is played
- /games/1/hit	                When a user decides to ‘hit’, immediately redirects to the game’s show
- /games/1/stand	        When a user decides to ‘stand’, immediately redirects to the game’s show
- /store                        Store page where users with few tokens remaining can refill on 100 tokens


Key views and models:

-- Game - 
- includes the most important view: show (/games/1). The show view in Game is where a user is able to play blackjack
- Betting view allows users to select how much they wish to bet on the next blackjack game (/games/1/bet)
- The game model contains methods necessary for our game to run.

-- Gamesessions - No important views (/game_sessions_new redirects to a new Game)

-- Users - 

- The users page view lists all the users signed up to the site (/users)	
- The user profile page shows a user’s account information including name, email and number of wins accumulated (/users/1)
- The user settings page allows a user to edit his profile including name, email or and/or password (/users/1/edit)
- The login page includes a form allowing a user to input his/her email and password for his/her account (/login)
- Redirects to the home page after user clicks the logout button (/logout)
- The user model contains methods necessary for our game to run.

-- Static Pages -
- Updated home page with login form on the home page, rather than as separate view (/)

--Leaderboard Page--
-Leaderboard page which allows users to see how they rank against other users based on win totals (/leaders) 



Dependencies:

- Using deck of cards API: https://deckofcardsapi.com/

- Mail_form: https://github.com/heartcombo/mail_form
        - This gem allowed us to create a form for our users to submit questions or comments they may have without having to actually email us theirselves. We utilized the gem by installing it and writing “require ‘mail_form’” in the controller. We also created a scaffold for contact and within the controller for contact for def create we were able to use mail_forms main feature (deliver). This was done with @contact.deliver which then attempts to send the email from the form. Lastly we needed to include a delivery method using SMTP in both the development and production files which works well with gmail allowing us to create a gmail account for our application and putting its port, domain, account name and password in the file. This then allows the emails to be sent when contact.deliver is called. 

- Faker

- Default gems and gems from RORT
