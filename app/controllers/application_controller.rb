require './lib/formatters/money_formatter'

class ApplicationController < ActionController::API
  include MoneyFormatter
end
