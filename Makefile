

install:
	echo on Ubuntu:
	sudo apt-get install postgresql-client libpq5 libpq-dev
	bundle install

run:
	bundle exec rails s