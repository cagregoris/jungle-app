class Admin::SalesController < ApplicationController
  def index
    @active_sale = Sale.active
    @sales = Sale.all
  end


end
