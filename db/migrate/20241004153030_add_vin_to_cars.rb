class AddVinToCars < ActiveRecord::Migration[7.2]
  def change
    add_column :cars, :vin, :string
  end
end
