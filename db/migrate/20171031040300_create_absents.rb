class CreateAbsents < ActiveRecord::Migration[5.0]
  def change
    create_table :absents do |t|
      t.datetime :absentDate
      t.string :reson
      t.integer :student_id
      t.integer :lecture_id
      t.timestamps
    end
  end
end
