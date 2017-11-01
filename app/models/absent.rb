class Absent < ApplicationRecord
  # student 테이블을 주인으로 모실꺼에요~ 아흥
  belongs_to :student
end
