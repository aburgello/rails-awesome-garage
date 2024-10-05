class AddVotesCountToCars < ActiveRecord::Migration[7.2]
  def change
    add_column :cars, :votes_count, :integer
  end
end
