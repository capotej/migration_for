class <%= migration_class_name %> < ActiveRecord::Migration

   def self.up
   <% parsed_commands.each do |command| %>
      <%= command %>
   <% end %>
   end

   def self.down
     #waiting for reversible migrations in rails 3.1!
   end

end
 
