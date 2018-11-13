# frozen_string_literal: true
require 'rails_helper'

describe "Categorie Controller", type: :request do
  let(:user) { FactoryBot.create :user }
  let!(:category) { FactoryBot.create :category }

  it "show topic in categories" do
    sign_in user
    get "/categories/#{category.id}"
    expect(response.status).to eq 200
  end
end
