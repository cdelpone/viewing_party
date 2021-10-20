# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Friendship.destroy_all
User.destroy_all

ruby = User.create(email: 'ruby@rubymail.com', password: 'ruby', password_confirmation: 'ruby')
python = User.create(email: 'python@pythonmail.com', password: 'python', password_confirmation: 'python')
java = User.create(email: 'java@javamail.com', password: 'java', password_confirmation: 'java')
node = User.create(email: 'node@nodemail.com', password: 'node', password_confirmation: 'node')
react = User.create(email: 'react@reactmail.com', password: 'react', password_confirmation: 'react')
css = User.create(email: 'css@cssmail.com', password: 'css', password_confirmation: 'css')
sql = User.create(email: 'sql@sqlmail.com', password: 'sql', password_confirmation: 'sql')
linux = User.create(email: 'linux@linuxmail.com', password: 'linux', password_confirmation: 'linux')

ruby.friendships.create(friend: python)
ruby.friendships.create(friend: java)
ruby.friendships.create(friend: node)
ruby.friendships.create(friend: react)
ruby.friendships.create(friend: css)
ruby.friendships.create(friend: sql)
ruby.friendships.create(friend: linux)

python.friendships.create(friend: java)
python.friendships.create(friend: node)
python.friendships.create(friend: react)
python.friendships.create(friend: css)
python.friendships.create(friend: sql)
python.friendships.create(friend: linux)

java.friendships.create(friend: node)
java.friendships.create(friend: react)
java.friendships.create(friend: css)
java.friendships.create(friend: sql)
java.friendships.create(friend: linux)

node.friendships.create(friend: react)
node.friendships.create(friend: css)
node.friendships.create(friend: sql)
node.friendships.create(friend: linux)

react.friendships.create(friend: css)
react.friendships.create(friend: sql)
react.friendships.create(friend: linux)

css.friendships.create(friend: sql)
css.friendships.create(friend: linux)

sql.friendships.create(friend: linux)

party = ruby.parties.create(movie_id: 118340, movie_title: "Guardians of the Galaxy", duration: 200, date: "2022-01-02", time: "04:30:00 UST")

party.invite_friends_by_ids([python.id, node.id, java.id, react.id, css.id, sql.id, linux.id])
