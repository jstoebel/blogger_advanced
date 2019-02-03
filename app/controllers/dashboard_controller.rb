class DashboardController < ApplicationController
  def show
    @dashboard = Rails.cache.fetch(:dashboard) do
      Dashboard.new
    end
  end
end
