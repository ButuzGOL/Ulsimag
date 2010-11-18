class SettingsController < ApplicationController
  before_filter :authenticate
  before_filter :set_title
  
  private
    def authenticate
      deny_access unless signed_in?
    end

    def set_title
      @title = "Settings"
    end
end
