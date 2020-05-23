class RelateVotesToUserAndWork < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :user, index: true, foreign_key: true, on_delete: :cascade
    add_reference :votes, :work, index: true, foreign_key: true, on_delete: :cascade
  end
end
