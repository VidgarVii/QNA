require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question).counter_cache(true) }
  it { should belong_to :author }
  it { should validate_presence_of :body }
end
