class LmController < ApplicationController

    def lm
      myJson ={"1" => "안녕하세요", "2" => "반갑습니다"}
      render json: myJson
    end

    def sign_up
      u = User.new
      u.gender = params[:gender]
      u.user_id = params[:id]
      u.password = params[:pw]
      u.name = params[:name]
      u.save

      myJson = {"result" => TRUE, "message" => "회원가입 성공" , "user" => u}
      render json: myJson

    end

    def sign_in
      if User.where(user_id: params[:id], password: params[:pw]).exists?

        u = User.where(user_id: params[:id], password: params[:pw]).first

        myJson = {"result" => TRUE, "message" => "로그인성공", "user" => u}
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

end
