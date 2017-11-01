class LmController < ApplicationController


    def sign_up
      st = Student.new
      st.loginId = params[:login_id]
      st.loginPw = params[:login_pw]
      st.name = params[:name]
      st.phone = params[:phone]
      st.save

      myJson = {"result" => TRUE, "message" => "회원가입 성공" , "student" => st}
      render json: myJson

    end

    def sign_in
      if Student.where(loginId: params[:login_id], loginPw: params[:login_pw]).exists?

        st = Student.where(loginId: params[:login_id], loginPw: params[:login_pw]).first

        myJson = {"result" => TRUE, "message" => "로그인성공", "student" => st}
        render json: myJson

      else

        myJson = {"result" => FALSE, "message" => "로그인 실패"}
        render json: myJson

      end

    end

    def post_list

     p = Post.new
     p.user_id = params[:id]
     p.content = params[:content]
     p.save

     myJson = {"result" => TRUE,  "message" => "게시글 등록에 성공하였습니다.", "post" => p}
     render json: myJson

    end

    def insertDummys
      s = Student.new
      s.name = "A학생"
      s.phone = "010-1111-1111"
      s.save

      s = Student.new
      s.name = "B학생"
      s.phone = "010-2222-2222"
      s.save

      ab = Absent.new
      ab.absentDate = "2017-10-01"
      ab.reson = "1번 사유"
      ab.student_id = 1
      ab.save

      ab = Absent.new
      ab.absentDate = "2017-10-02"
      ab.reson = "2번 사유"
      ab.student_id = 1
      ab.save

      ab = Absent.new
      ab.absentDate = "2017-10-03"
      ab.reson = "3번 사유"
      ab.student_id = 1
      ab.save

      render plain: "토드에서 확인"

    end

    def getFirstStudentAbsentList

    s = Student.find(1)
    myJson = {"1번학생 결석목록" => s.absent}
    render json: myJson

  end

  def absent
    ab = Absent.new
    ab.absentDate = params[:absentdate]
    ab.reson = params[:reson]
    ab.student_id = params[:student_id]
    ab.lecture_id = params[:lecture_id]
    ab.save

    myJson = {"result" => TRUE,  "message" => "게시글 등록완료", "absent" => ab, "student" => ab.student}
    render json: myJson

  end

end
