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
      expect { post :create, params: { memory: attributes } }.to change(Memory, :count).by 1
    end
    it 'should not create memory' do
      user = FactoryBot.create :user
      sign_in user
      expect { post :create, params: { memory: { local: 'Rio de Janeiro' } } }.to change(Memory, :count).by 0
    end
  end

  describe '#show' do
    it 'renders a memory' do
      user = FactoryBot.create :user
      sign_in user
      memory = FactoryBot.create(:memory)
      get :show, params: { id: memory.id }
      expect(response).to render_template 'memories/show'
    end
  end

  describe '#edit' do
    it 'renders' do
      user = FactoryBot.create :user
      sign_in user
      memory = FactoryBot.create(:memory)
      get :edit, params: { id: memory.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    it 'update users' do
      user = FactoryBot.create :user
      sign_in user
      memory = FactoryBot.create(:memory)
      patch :update, params: { id: memory.id, memory: { description: 'new description' } }
      expect(memory.reload.description).to eq 'new description'
    end
  end

  describe '#destroy' do
    it 'destroys a memory' do
      user = FactoryBot.create :user
      sign_in user
      memory = FactoryBot.create(:memory)
      expect { delete :destroy, params: { id: memory.id } }.to change(Memory, :count).by(-1)
    end
  end

  describe '#index' do
    before :all do
      Memory.delete_all
      User.delete_all

      @user = FactoryBot.create :user
      @user2 = FactoryBot.create :user

      @m1 = Memory.create(description: 'memory', date: Date.today - 2.days, weather: 'Sunny', local: 'Brasília',
                          user: @user).id
      @m2 = Memory.create(description: 'memory', date: Date.today - 2.days, weather: 'Sunny', local: 'Rio de Janeiro',
                          user: @user).id
      @m3 = Memory.create(description: 'memory', date: Date.today - 2.days, weather: 'Sunny', local: 'Brasília',
                          user: @user).id
      @m4 = Memory.create(description: 'memory', date: Date.today - 2.days, weather: 'Storm', local: 'Brasília',
                          user: @user).id
      @m5 = Memory.create(description: 'memory', date: Date.today - 2.days, weather: 'Storm', local: 'Brasília',
                          user: @user2).id

      @m6 = Memory.create(description: 'memory', date: Date.today - 1.day, weather: 'Scattered clouds', local: 'Brasília',
                          user: @user).id
      @m7 = Memory.create(description: 'memory', date: Date.today - 1.day, weather: 'Sunny', local: 'Rio de Janeiro',
                          user: @user).id
      @m8 = Memory.create(description: 'memory', date: Date.today - 1.day, weather: 'Sunny', local: 'Rio de Janeiro',
                          user: @user).id
      @m9 = Memory.create(description: 'memory', date: Date.today - 1.day, weather: 'Sunny', local: 'Rio de Janeiro',
                          user: @user2).id

      @m10 = Memory.create(description: 'memory', date: Date.today, weather: 'Storm', local: 'Brasília', user: @user).id
      @m11 = Memory.create(description: 'memory', date: Date.today, weather: 'Storm', local: 'Rio de Janeiro',
                           user: @user).id
      @m12 = Memory.create(description: 'memory', date: Date.today, weather: 'Storm', local: 'Rio de Janeiro',
                           user: @user).id
      @m13 = Memory.create(description: 'memory', date: Date.today, weather: 'Storm', local: 'Rio de Janeiro',
                           user: @user2).id
    end
    it 'should retrieve only current user memories' do
      sign_in @user
      get :index
      memories = assigns(:memories)
      expect(memories.count).to eq 10
    end
    it 'should retrieve memories sorted by date (DESC), weather, and local' do
      sign_in @user
      get :index
      memories = assigns(:memories)
      expect(memories.pluck(:id)).to eq [@m10, @m12, @m11, @m6, @m7, @m8, @m4, @m3, @m1, @m2]
    end
  end
end
