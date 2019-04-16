require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:commentable).touch }
  it { should belong_to :author }
  it { should validate_presence_of :body }

  it_behaves_like 'sphinx', Comment
end
