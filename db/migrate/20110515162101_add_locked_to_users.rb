class AddLockedToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :locked, :boolean, :default => false
  end

  def self.down
    remove_column :users, :locked
  end
end
