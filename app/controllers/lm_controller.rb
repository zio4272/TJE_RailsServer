class LmController < ApplicationController


    def register_user
      # 회원가입 : 사용자에게 학생정보를 받아 회원으로 DB에 추가.

      # 사용자 클래스 하나 생성
      s = Student.new

      # 학생 클래스에 들어있는 loginId 항목은
      # 클라이언트가 id라고 꼬리표를 달아서 보내주는 항목으로 대입.
      s.loginId = params[:id]
      s.loginPw = params[:pw]
      s.name = params[:name]
      s.phone = params[:phone]

      # 클래스 정보를 DB에 저장
      s.save

      # 동작을 하고 나면 클라이언트에게 결과를 전송
      # 클라이언트는 JSON을 받는게 제일 편함. => JSON으로 가공해서 전송

      # 수행 결과를 저장할 객체
      resultJson = {"result" => TRUE, "message" => "user registered successfully"}
      render json: resultJson

    end

    def login
      # 로그인? 클라이언트가 요청하는
      # 아이디/비밀번호가 우리의 회원 장부에 있는지 검사.

      # 아이디와 비밀번호가 모두 일치하는 학생[Student]이 있는가? 검색
      if Student.where(loginId: params[:id], loginPw: params[:pw]).exists?
        # 아이디와 비번 모두 일치하는 학생이 존재.
        # 우리의 회원이 맞으므로 => 로그인에 성공.
        # 로그인에 성공했음을 앱한테 전파.
        # 앱에다 메세지를 날리는건? JSON 만들어서 render json:

        # 로그인에 성공하면 해당 학생의 정보를 첨부
        # 검색 결과중 첫번째 학생이 해당 학생이라고 가정.
        std = Student.where(loginId: params[:id], loginPw: params[:pw]).first

        #결과 JSON에 항목 추가.
        # Student => std 객체

        resultJson = {"result" => TRUE, "message" => "login ok!", "Student" => std}
        render json: resultJson
      else
        # 존재하지 않는다. => 회원이 아니다. => 로그인 실패.
        resultJson = {"result" => FALSE, "message" => "login failed!"}
        render json: resultJson
      end



    end

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

    myJson = {"result" => TRUE,  "message" => "게시글 등록완료", "absent" => ab}
    render json: myJson

  end


  def all_absent
    absent = Absent.all()

    absArr = Array.new

    absent.each do |x|
      abs = x.as_json
      abs["student"] =  x.student

      absArr << abs

    end

    resultJson = {"result" => TRUE, "message" => "get list ok", "absent" => absArr }
    render json: resultJson

  end

  def testFirstAbsent
    abs = Absent.first()
    tempJson = abs.as_json
    tempJson["student"] = abs.student

    resultJson = {"result" => TRUE, "message" => "get abs ok", "abs" => tempJson }
    render json: resultJson

  end

  def test8std

    std = Student.find(1)
    tempJson = std.as_json
    tempJson["absents"] = std.absents

    resultJson = {"result" => TRUE, "message" => "get abs ok", "abs" => tempJson }
    render json: resultJson


  end

end
