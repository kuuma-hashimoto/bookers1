class BooksController < ApplicationController
  def new
  end

  def create
    # １. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      redirect_to book_path(@book.id)
      flash[:notice] = "Book was successfully created."
      
    else
      # 3. フラッシュメッセージを定義し、new.html.erbを描画する
      @books = Book.all
      render :index
    end
  end
  
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
   
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end  
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end  
  
private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
