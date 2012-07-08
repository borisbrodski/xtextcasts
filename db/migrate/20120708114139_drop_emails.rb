class DropEmails < ActiveRecord::Migration
  def self.up
    drop_table :emails
  end

  def self.down
    create_table :emails do |t|
      t.string :email
      t.string :tag
      t.timestamps
    end
  end
end
