# frozen_string_literal: true

class Account
  # :nodoc:
  class ConnectionsController < Account::BaseController
    before_action :find_connection_by_provider, only: :callback
    before_action :find_connection, only: %i[edit update destroy]

    def index
      @connections = Connection.where(account: current_account)
      render layout: 'replacement'
    end

    def edit; end

    def update
      if @connection.update_attributes(connection_params)
        flash[:success] = I18n.t('accounts.connections.update.success')
        redirect_to account_connections_path
      else
        render :edit
      end
    end

    def destroy
      @connection.destroy
      flash[:success] = I18n.t('accounts.connections.destroy.success')
      redirect_to account_connections_path
    end

    def callback
      if update_connection
        flash[:success] = 'Alhamdulillah, your Twitter account has been updated'
      elsif create_connection
        flash[:success] = 'Alhamdulillah, your Twitter account was connected'
      else
        flash[:danger] = 'An error occurred'
      end

      redirect_to edit_account_connection_path(@connection)
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
      @connection = Connection.create_with_omniauth! auth, current_account
    end

    def update_connection
      @connection.update_attributes!(
        name: auth[:info][:nickname],
        token: auth[:credentials][:token],
        secret: auth[:credentials][:secret]
      )
    rescue StandardError
      false
    end

    def connection_params
      params.require(:connection).permit(:active, :translation_id, :hashtags)
    end
  end
end
