class ApplicationController < ActionController::API

  def format_money(cents)
    '%.2f' % (cents.to_f / 100)
  end
end
