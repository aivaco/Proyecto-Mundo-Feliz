class AddPersonaToUser < ActiveRecord::Migration
  def change
    add_reference :users, :persona, index: true, foreign_key: true
  end
end
