require 'bundler'
Bundler.require
require 'json'

# DB = {
#   conn: SQLite3::Database.new('db/star_wars.sqlite')
# }

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/star_wars.sqlite'
)
ActiveRecord::Base.logger = nil
require_all "lib"

#duncan was here
