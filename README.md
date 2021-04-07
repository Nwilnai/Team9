# README

Heroku Link for deployed app: https://gentle-stream-27906.herokuapp.com/

Github repo: https://github.com/Nwilnai/Team9

Trello Link: https://trello.com/b/fLieZouT/capstone-team-9


Functionality: Users can sign up, sign in and sign out of their accounts. Once logged in, users can play a game of blackjack against the computerized dealer. Within each game of blackjack, users can decide to either ‘hit’ or ‘stand’ based on the cards that both they and the dealer have been dealt. Users can also access their profile page and the number of wins they have accumulated.

URL Patterns:
/			    Home page
/users			Users page (lists all users)
/users/1		Profile page (gets user 1)
/users/1/edit	Settings page (edits user 1)
/login			Login page (displays user login prompt)
/logout			Logout page
/help			Help page
/about			About page

/game_sessions/new	New game session directs to a new game

/games/1		Game 1’s show page, where blackjack game is played
/games/1/hit	When a user decides to ‘hit’, immediately redirects to the game’s show
/games/1/stand	When a user decides to ‘stand’, immediately redirects to the game’s show

Key views and models:
    Game - includes the most important view: show (/games/1)
         - The show view in Game is where a user is able to play blackjack
    Gamesessions
         - No important views (/game_sessions_new redirects to a new Game)
    Users
         - The users page view lists all the users signed up to the site (/users)	
         - The user profile page shows a user’s account information including name, email and number of wins accumulated (/users/1)
         - The user settings page allows a user to edit his profile including name, email or and/or password (/users/1/edit)
         - The login page includes a form allowing a user to input his/her email and password for his/her account (/login)
         - Redirects to the home page after user clicks the logout button (/logout)	

Unimplemented views:
    - Betting view inside Game which allows users to select how much they wish to bet on the next blackjack game, or if they wish to quit (/games/1/bet)
    - Updated home page with login and signup forms on the home page, rather than as separate views (/)
    - Leaderboad page inside User which allows users to see how they rank against other users based on win totals (/users/leaders)


Dependencies:
    - Using deck of cards API: https://deckofcardsapi.com/
    - Mail_form: https://github.com/heartcombo/mail_form
        - This gem allowed us to create a form for our users to submit questions or comments they may have without having to actually email us theirselves. We utilized the gem by installing it and writing “require ‘mail_form’” in the controller. We also created a scaffold for contact and within the controller for contact for def create we were able to use mail_forms main feature (deliver). This was done with @contact.deliver which then attempts to send the email from the form. Lastly we needed to include a delivery method using SMTP in both the development and production files which works well with gmail allowing us to create a gmail account for our application and putting its port, domain, account name and password in the file. This then allows the emails to be sent when contact.deliver is called. 
    - Faker
    - Default gems and gems from RORT
