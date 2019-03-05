require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do
  it_behaves_like 'oath_callbacks', :github
  it_behaves_like 'oath_callbacks', :vkontakte
  it_behaves_like 'oath_callbacks', :instagram
end
