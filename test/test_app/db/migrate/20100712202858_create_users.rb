class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
    end
  end

  def self.down
    create_table :users do |t|
      t.remove :name
    end
  end
end
