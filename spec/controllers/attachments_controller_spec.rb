require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:answer) { create(:answer, :with_file) }
  let(:delete_file) { delete :destroy, params: {id: answer.files.first }, format: :js }


  describe 'DELETE #destroy' do

    it 'delete attachment' do
      sign_in(answer.author)

      expect { delete_file }.to change(ActiveStorage::Attachment, :count).by(-1)
    end

    it 'unable delete foreign files' do
      sign_in(user)

      expect { delete_file }.to_not change(ActiveStorage::Attachment, :count)
    end
  end
end
