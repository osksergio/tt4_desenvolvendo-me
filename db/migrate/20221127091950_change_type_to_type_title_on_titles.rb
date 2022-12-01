class ChangeTypeToTypeTitleOnTitles < ActiveRecord::Migration[6.1]
  def change
    rename_column(:titles, :type, :type_title)
  end
end
