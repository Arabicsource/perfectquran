# frozen_string_literal: true

class Contact
  include ActiveModel::Validations

  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @body = params[:body]
  end

  attr_accessor :name, :email, :body

  validates :name, presence: true
  validates :email, presence: true
  validates :body, presence: true
end
