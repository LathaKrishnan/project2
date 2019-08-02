require 'active_record'
require'pry'

options = {
    adapter:'postgresql',
    database: 'pmprep35'
}

ActiveRecord::Base.establish_connection(options)
