class CreateRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :registrations do |t|
      t.datetime :check_in
      t.datetime :check_out
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
