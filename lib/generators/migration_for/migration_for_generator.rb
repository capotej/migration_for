require 'rails/generators'
require 'rails/generators/migration'     
 
class MigrationForGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  argument :commands, :type => :array
  source_root File.expand_path('../templates', __FILE__) 

  #available tranformations with their arity
  AVAILABLE_COMMANDS = { 
    :create_table => 1,
    :rename_table => 2,
    :drop_table => 1,
    :add_column => 3,
    :rename_column => 3,
    :change_column => 3,
    :remove_column => 2,
    :add_index => 2,
    :remove_index => 2,
  }


  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def migration_name
    commands.join.gsub(' ','_').gsub(':', '_')
  end  

  def commands_to_arguments(cmds = nil)
    cmds.map { |c| ":#{c}" }.join(',') if cmds
  end

  def lookup_command(command = nil)
    return unless command
    cmds = command.split(':')
    if AVAILABLE_COMMANDS.include?(cmds.first.to_sym)
      arity = AVAILABLE_COMMANDS[cmds.first.to_sym]
      if cmds.length == arity + 1
        "#{cmds.shift} #{commands_to_arguments(cmds)}"
      end
    end
  end

  def parsed_commands
    commands.map { |c| lookup_command(c) }
  end

  def migration_class_name
    migration_name.camelize
  end
  
  def create_migration_file
    migration_template 'migration.rb', "db/migrate/#{migration_name}.rb"
  end
  
end
