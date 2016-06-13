require 'rails_helper'

RSpec.describe SponsorsController, :type => :controller do
  let!(:sponsor) { create(:sponsor) }

  it "show should return all sponsors" do
    get :show

    expect(response.status).to eq(200)
    expect(assigns(:sponsors).count).to eq(2)
  end

  it "show should return one sponsor" do
    get :show, { id: sponsor.id }

    expect(response.status).to eq(200)
    expect(assigns(:sponsors).count).to eq(1)
    expect(assigns(:sponsors).first.id).to eq(sponsor.id)
  end
end
