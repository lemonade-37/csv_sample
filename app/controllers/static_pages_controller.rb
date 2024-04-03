class StaticPagesController < ApplicationController
  def index
    @users = User.all
    @sales = Sale.all
    @account_informations = AccountInformation.all
  end
end
