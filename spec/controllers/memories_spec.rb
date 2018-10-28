require 'rails_helper'

RSpec.describe MemoriesController, type: :controller do
  describe '#new' do
    it 'should create new memory with local and weather' do
      user = FactoryBot.create :user
      sign_in user
      get :new
      memory = assigns(:memory)
      expect(memory.local).to eq 'Brasília'
      expect(memory.weather).not_to be_nil
    end
  end

  describe '#create' do
    it 'should create memory' do
      user = FactoryBot.create :user
      sign_in user
      attributes = FactoryBot.attributes_for :memory
      expect { post :create, params: {memory: attributes} }.to change(Memory, :count).by 1
    end
    it 'should not create memory' do
      user = FactoryBot.create :user
      sign_in user
      expect { post :create, params: {memory: {local: 'Rio de Janeiro'}} }.to change(Memory, :count).by 0
    end
  end
end