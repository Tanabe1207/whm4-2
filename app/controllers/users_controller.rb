class UsersController < ApplicationController
  def new
    #デフォルトで2つの入力欄を表示
    #Userクラスからnewメソッドでインスタンスを生成してる。
    #Userクラスはモデルuser.rbの中にあり、別のクラスのApplicationRecordの継承を受けている。
    #newメソッドはクラスメソッドの一つであり、ApplicationRecord内に定義されている。
    #new methodは一人分のデータ入れ物を塊を一つつくること。create methodならnewとsaveを同時にできる
    #new.html.erbに紐づいたformを作りたいので、インスタンス変数にUserを格納。
    #then rendered on viewer "new.html.erb"
  end

  def create
    @user=User.new(user_params)#strong parameterに定義されている

#再度@userにUserテーブルを構築。その際引数をuser_paramsメソッドにすることで、
#viewで格納したparamsの値が入ったテーブルを引数とすることができる。
#routes.rbで、POSTメソッド（HTTPメソッドの一つ）POST	users	users#createを指示しているから、
#createを実行するとデータがデータベースに保存される。
    # user.user_language_levels = [UserLanguageLevel.new(user:user,language_id:up[:language_id],level:up[:level])]
    # debugger
    if @user.save
      @lang = Language.new(languages_params)
      @lang.user_id = User.last.id
      @lang.save
      redirect_to root_path, notice:'登録が完了しました'#saveできたらroot pathに飛ぶの意
    else
      flash.now[:alert]="登録に失敗しました"#noticeとalertは自動的にRailsに格納されているflashという変数の中に入ります。
      #<%= flash[:alert] %>でviewの中でアクセスできる。
      render :new #renderは呼び出すviewを指定する。
    end
  end

  def show
    #ログインユーザーのレコードの取得
    @user_my_page = User.find(params[:id])
    #なお、findはidのみを引数に取るメソッド
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to controller: 'users', action: 'show', id:current_user, notice:'ユーザー情報を更新しました'
    else
      flash.now[:alert]="登録に失敗しました"
      render :edit
    end
  end

  def retire
  end

  def destroy
    if current_user.destroy
      reset_session
      redirect_to root_path, notice:'退会が完了しました'
    else
      render :retire
    end
  end



  private
  #viewから送られてきたデータは、paramsに格納されている。paramsを適切な各テーブルに挿入。
  #この作業がuser_paramsメソッド。
    def user_params
      params.require(:user).permit(:nickname, :mail, :password, :password_confirmation, :my_image,
        :gender, :birthday, :nationality, :hobby, :introduce_yourself,)
         # languages_attributes: [:id, :language, :level, :_destroy])
    end
    def languages_params
      params.require(:user).permit( :language, :level)
    end
    #  languages_attributesの前にコロンいらない？
end
# t.string :nickname
# t.string :mail
# t.string :my_image
# t.string :gender
# t.date :birthday
# t.string :nationality
