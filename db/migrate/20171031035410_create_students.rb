class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :loginId
      t.string :loginPw
      t.string :name
      t.string :phone
      t.timestamps
    end
  end
end
