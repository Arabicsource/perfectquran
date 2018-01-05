# frozen_string_literal: true

module Accounts
  # :nodoc:
  class ConnectionsController < Accounts::BaseController
    before_action :find_connection_by_provider, only: :callback
    before_action :find_connection, only: %i[edit update destroy]

    def index
      @connections = Connection.where(account: current_account)
    end

    def edit; end

    def update
      if @connection.update_attributes(connection_params)
        flash[:success] = I18n.t('accounts.connections.update.success')
        redirect_to accounts_connections_path
      else
        render :edit
      end
    end

    def destroy
      @connection.destroy
      flash[:success] = I18n.t('accounts.connections.destroy.success')
      redirect_to accounts_connections_path
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

    def find_connection_by_provider
      @connection = Connection.find_by(
        provider: 'twitter', provider_uid: auth[:uid]
      )
    end

    def find_connection
      @connection = Connection.find_by!(
        id: params[:id], account: current_account
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
        connection.status = 'inactive'
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

    def connection_params
      params.require(:connection).permit(:status)
    end
  end
end
