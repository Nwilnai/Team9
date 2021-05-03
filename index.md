## Welcome to Team 9's Project Pages

### Our Team
- Nathaniel Wilnai - nathanielw@brandeis.edu
- Henry Arvans - harvans5@brandeis.edu
- Jared Panson - jaredpanson@brandeis.edu

### Our Product
What the purpose of the product is, what kind of user would want it.

### Functionality
- Users can sign up, sign in and sign out of their accounts. 
- When users sign up, they get 500 tokens. 
- Once logged in, users can play a game of blackjack against the computerized dealer. 
- Within each game of blackjack, users can choose an amount of tokens to bet (from 10 to their total # of tokens) and then users can decide to either ‘hit’ or ‘stand’ depending on the cards that they have received, as well as the dealer's single showing card. 
- Users can also access their profile page, which contains their email, the number of tokens they have accumulated, and an option to update their sign-up information. 
- If a user runs out of tokens, they can visit our store to restock! In our store, we gift 100 tokens to any user with less than 100 tokens. 
- If a player begins a game with an insufficient amount of tokens, a link to the store will appear on the betting page. 
- Users can also visit the leaderboard page which shows all users, and their rank by total amount of tokens. 
- If users are new to blackjack, they can view the rules of blackjack in our about page, as well as learn some strategies for becoming the ultimate blackjack guru! 
- If users encounter any problems, they can visit the help page, where they can use our mail form to easily shoot us an email!

### Schema
Summarize the schema but don’t go table by table, field by field in the narrative.
Users: Our user table remembers important information about the user, both regarding their login information as well as game related information. Such game-related information includes wins, token amounts, bet amounts, etc. 

Games: Our games table remembers the deck_id assigned to it upon creation. This deck_id is a unique id provided by the Deck of Cards API that allows us to retrieve information about the state of the cards at any time. 

Game_sessions: The join table between users and games. 

### Technologies
- Heroku Link for deployed app: https://gentle-stream-27906.herokuapp.com/
- Github repo: https://github.com/Nwilnai/Team9
- Trello Link: https://trello.com/b/fLieZouT/capstone-team-9
- Deck of Cards API: https://deckofcardsapi.com/
- Mail_form: https://github.com/heartcombo/mail_form 
- Faker: https://github.com/faker-ruby/faker
- Github Pages
- Github Actions (Workflow for CI)
- New Languages (HTML, CSS, SCSS, JS)
- VSCode

### Interesting Engineering
- Mail_form: https://github.com/heartcombo/mail_form - This gem allowed us to create a form for our users to submit questions or comments they may have without having to actually email us theirselves. We utilized the gem by installing it and writing “require ‘mail_form’” in the controller. We also created a scaffold for contact and within the controller for contact for def create we were able to use mail_forms main feature (deliver). This was done with @contact.deliver, which then attempts to send the email from the form. Lastly we needed to include a delivery method using SMTP in both the development and production files, which works well with gmail, allowing us to create a gmail account for our application and putting its port, domain, account name and password in the file. This then allows the emails to be sent when contact.deliver is called.

- Deck of Cards API: https://deckofcardsapi.com/ - This API allows for the creation of decks, each of which can be split into piles. The API saves the state of each deck (and pile), allowing us to use it to represent every player's hand. We have a new deck assigned to each game, from which all the cards are drawn. This has its upsides and downsides. On the upside, we didn't have to create cards and save their state. On the downside, however, our website takes a bit longer to respond due to the API requests going on in the background, and the request fails once in a while. However, one of our primary goals in doing this project was learning how to use an API, and this API served that purpose well.

### Methodologies
Development, deployment and testing methodologies and results.

### Architecture
Include at least one screenshot and also a diagram of the architecture


# Default Text (To Be Deleted)

You can use the [editor on GitHub](https://github.com/Nwilnai/Team9/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).
