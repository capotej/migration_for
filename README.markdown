# MigrationFor
Write migrations right from the command line!

### Dependencies
Rails 3 only

### Installation
From your rails directory
 
    rails plugin install git://github.com/capotej/migration_for.git

### Example Usage

  Quickly add an index to posts for posts_id
    rails g migration_for add_index:posts:posts_id

  Or create a table and a bunch of fields
    rails g migration_for create_table:posts add_column:posts:title:string add_column:posts:user_id:integer add_index:posts:user_id
 
  Look over the generated migrations then run them!
    rake db:migrate

  All [activerecord transformations](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html) are supported

Copyright (c) 2011 Julio Capote, released under the MIT license
