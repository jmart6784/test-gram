class ChangeSavedToBookmark < ActiveRecord::Migration[6.0]
  def change
    rename_table :saveds, :bookmark
  end
end
