class AddCityCountryAndPositionOthersInUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :city,           :string
    add_column :users, :country,        :string
    add_column :users, :position_other, :string
  end
end
