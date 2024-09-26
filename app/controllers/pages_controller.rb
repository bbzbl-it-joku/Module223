class PagesController < ApplicationController
  before_action :set_user, only: [ :home, :about, :error ]

  def home
  end

  def about
  end

  def error
  end
end
