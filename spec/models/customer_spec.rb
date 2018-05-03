require 'rails_helper'

describe Customer, type: :model do
  describe 'Relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
  end
end
