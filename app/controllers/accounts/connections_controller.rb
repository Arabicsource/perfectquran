# frozen_string_literal: true

module Accounts
  # :nodoc:
  class ConnectionsController < Accounts::BaseController
    def callback
      Connection.create! do |connection|
        connection.name = request.env['omniauth.auth'][:info][:nickname]
        connection.provider = 'twitter'
        connection.provider_uid = request.env['omniauth.auth'][:uid]
        connection.token = request.env['omniauth.auth'][:credentials][:token]
        connection.secret = request.env['omniauth.auth'][:credentials][:secret]
        connection.account = current_account
      end

      redirect_to accounts_connections_path
    end
  end
end
