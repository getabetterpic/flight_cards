require 'rails_helper'

RSpec.describe '/launches', type: :request do
  let(:launch_admin) { FactoryBot.create(:user, :launch_admin) }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /launches/new' do
    context 'with an authorized user' do
      before { sign_in launch_admin }

      it 'initializes a new launch' do
        get '/launches/new'
        expect(response).to have_http_status :ok
      end
    end

    context 'with an unauthorized user' do
      before { sign_in user }

      it 'redirects to launches_path' do
        get '/launches/new'
        expect(response).to redirect_to launches_path
        follow_redirect!
        expect(response.body).to include 'not authorized to do that.'
      end
    end
  end

  describe 'POST /launches' do
    context 'with an authorized user' do
      before { sign_in launch_admin }
      let(:params) { { launch: { name: 'Creekside Farms', date: '2020-09-20' } } }

      it 'creates a new launch' do
        expect {
          post '/launches', params: params
        }.to change { Launch.count }.by(1)
        expect(response).to redirect_to launches_path
      end

      context 'with missing params' do
        let(:params) { { launch: { name: 'Creekside Farms' } } }

        it 'does not create a new launch' do
          expect {
            post '/launches', params: params
          }.to_not change { Launch.count }
        end
      end
    end

    context 'with an unauthorized user' do
      before { sign_in user }
      let(:params) { { launch: { name: 'Creekside Farms', date: '2020-09-20' } } }

      it 'redirects to launches_path' do
        expect {
          post '/launches', params: params
        }.to_not change { Launch.count }
        expect(response).to redirect_to launches_path
        follow_redirect!
        expect(response.body).to include 'not authorized to do that.'
      end
    end
  end

  describe 'PUT /launches/<launch_id>' do
    context 'with an authorized user' do
      before { sign_in launch_admin }
      let(:launch) { FactoryBot.create(:launch, admin: launch_admin) }
      let(:params) { { launch: { name: 'Mill Springs Academy' } } }

      it 'updates the launch' do
        expect {
          put "/launches/#{launch.id}", params: params
        }.to change { launch.reload.name }.to('Mill Springs Academy')
        expect(response).to redirect_to launches_path
      end
    end

    context 'with an unauthorized user' do
      before { sign_in user }
      let(:launch) { FactoryBot.create(:launch, admin: launch_admin) }
      let(:params) { { launch: { name: 'Mill Springs Academy' } } }

      it 'redirects to launches_path' do
        expect {
          put "/launches/#{launch.id}", params: params
        }.to_not change { launch.reload.name }
        expect(response).to redirect_to launches_path
        follow_redirect!
        expect(response.body).to include 'not authorized to do that.'
      end
    end
  end

  describe 'GET /launches' do
    before { sign_in user }
    let!(:launch1) { FactoryBot.create(:launch) }
    let!(:launch2) { FactoryBot.create(:launch, name: 'Mill Springs Academy') }

    it 'returns a list of launches' do
      get '/launches'
      expect(response.body).to include launch1.name
      expect(response.body).to include launch2.name
    end
  end
end
