class AddReferenceToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :companies, foreign_key: true
  end
end
