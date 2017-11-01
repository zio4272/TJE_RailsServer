class CreateStdLecs < ActiveRecord::Migration[5.0]
  def change
    create_table :std_lecs do |t|
      t.integer :student_id
      t.integer :lecture_id
      t.timestamps
    end
  end
end
