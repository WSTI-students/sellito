class HomepageController < ApplicationController
  def index;
    @categories = Category.all
    # zmniejsza ilosc zapytan do bazy z n+1 do wymaganego minimum
    #n+1 to nadmiarowa ilosc zapytan do bazy; niezoptymalizowane zapytanie do bazy, ktore wykonuje sie niepotrzebnie wiele
    # przy wyswietlaniu posta idzie zapytanie do bazy o posty wraz z kategoriami
    @posts = Post.all.includes(:categories).order('created_at DESC').limit(10)
  end

  def about; end

  def cookies; end
end
