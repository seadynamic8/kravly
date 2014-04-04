class AddPitchToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :pitch, :string
  end
end
