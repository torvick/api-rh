class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :rfc
      t.string :email
      t.string :phone
      t.string :city
      t.string :number_ext
      t.string :number_int
      t.string :postal_code
      t.string :state
      t.string :suburb
      t.string :address
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
