# frozen_string_literal: true

module Accounts
  # :nodoc:
  class ConnectionsController < Accounts::BaseController
    before_action :load_connection, only: :callback

    def index
      @connections = Connection.where(account: current_account)
    end

    def callback
      if update_connection
        flash[:success] = 'Alhamdulillah, your Twitter account has been updated'
      elsif create_connection
        flash[:success] = 'Alhamdulillah, your Twitter account was connected'
      else
        flash[:danger] = 'An error occurred'
      end

      redirect_to accounts_connections_path
    end

    private

    def load_connection
      @connection = Connection.find_by(
        provider: 'twitter', provider_uid: auth[:uid]
      )
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end

    def create_connection
      Connection.create! do |connection|
        connection.name = auth[:info][:nickname]
        connection.provider = 'twitter'
        connection.provider_uid = auth[:uid]
        connection.token = auth[:credentials][:token]
        connection.secret = auth[:credentials][:secret]
        connection.account = current_account
      end
    rescue
      false
    end

    def update_connection
      @connection.update_attributes!(
        name: auth[:info][:nickname],
        token: auth[:credentials][:token],
        secret: auth[:credentials][:secret]
      )
    rescue
      false
    end
  end
end
