class RemoveUserIdFromTracks < ActiveRecord::Migration
  def change
    remove_column :tracks, :user_id
  end
end
