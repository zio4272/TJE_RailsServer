class CreateLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :lectures do |t|
      t.string :name
      t.integer :teacher_id
      # 외래키 설정은 이파일에서 하지 않는다.
      # 차후에 Model 클래스에서 수정
      # 대신에 칼람자체는 여기 생성
      t.timestamps
    end
  end
end
