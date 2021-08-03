# Smartflix

A practice rails app for all things movie related


* Ruby version: 
  
2.7.2

* Setup

```
cd smartflix
bundle install
```

* Database setup
```
rails db:setup
rails db:migrate
```
* How to run the test suite
```
rspec
open coverage/index.html
```

* Deployment instructions
```
rails s
```
visit http://localhost:3000/movies/jumanji

then in a separate terminal
```
bundle exec sidekiq
```
* How to use

Enter a movie name after 'movies/' in the url to add a movie to the database. (only one word movies allowed)

Wait until 7am each day to see the database updated


Thanks for reading!
