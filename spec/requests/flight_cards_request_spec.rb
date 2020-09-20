require 'rails_helper'

RSpec.describe '/flight_cards' do
  let(:launch) { FactoryBot.create(:launch) }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /launches/<launch_id>/flight_cards/new' do
    context 'with an authenticated user' do
      before { sign_in user }

      it 'returns a 200 response' do
        get "/launches/#{launch.id}/flight_cards/new"
        expect(response.code).to eq '200'
      end
    end

    context 'without a user' do
      it 'redirects to sign in' do
        get "/launches/#{launch.id}/flight_cards/new"
        expect(response.code).to eq '302'
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /launches/<launch_id>/flight_cards' do
    context 'with an authenticated user' do
      before { sign_in user }

      context 'when successful' do
        let(:params) { { flight_card: { name: 'Jorge', rocket_name: 'Interceptor K' } } }

        it 'creates a new flight card' do
          expect {
            post "/launches/#{launch.id}/flight_cards", params: params
          }.to change { FlightCard.count }.by(1)
          expect(response).to redirect_to launch_flight_cards_path(launch.id)
        end
      end

      context 'when missing a required field' do
        let(:params) { { flight_card: { name: 'David Cain' } } }

        it 'does not create a new flight card' do
          expect {
            post "/launches/#{launch.id}/flight_cards", params: params
          }.to change { FlightCard.count }.by(0)
          expect(response.body).to include 'Flight Cards'
        end
      end
    end
  end

  describe 'GET /launches/<launch_id>/flight_cards' do
    context 'with an authenticated user' do
      before { sign_in user }
      let!(:flight_card) { FactoryBot.create(:flight_card, user: user, launch: launch) }

      it "lists the user's flight cards" do
        get "/launches/#{launch.id}/flight_cards"
        expect(response.body).to include flight_card.rocket_name
      end
    end
  end

  describe 'PUT /launches/<launch_id>/flight_cards/<flight_card_id>' do
    context 'with an authenticated user' do
      before { sign_in user }
      let(:flight_card) { FactoryBot.create(:flight_card, user: user, launch: launch) }
      let(:params) do
        {
          flight_card: {
            rocket_name: 'Big Bertha'
          }
        }
      end

      it 'updates the flight card' do
        expect {
          put "/launches/#{launch.id}/flight_cards/#{flight_card.id}", params: params
        }.to change { flight_card.reload.rocket_name }.to('Big Bertha')
      end
    end
  end

  describe 'DELETE /launches/<launch_id>/flight_cards/<flight_card_id>' do
    context 'with an authenticated and authorized user' do
      before { sign_in user }
      let!(:flight_card) { FactoryBot.create(:flight_card, user: user, launch: launch) }

      it 'deletes the flight card' do
        expect {
          delete "/launches/#{launch.id}/flight_cards/#{flight_card.id}"
        }.to change { FlightCard.count }.by(-1)
        expect(response).to redirect_to launch_flight_cards_path(launch.id)
      end
    end

    context 'with an authenticated but not authorized user' do
      let(:unauthorized_user) { FactoryBot.create(:user) }
      let!(:flight_card) { FactoryBot.create(:flight_card, user: user, launch: launch) }
      before { sign_in unauthorized_user }

      it 'returns an unauthorized error' do
        expect {
          delete "/launches/#{launch.id}/flight_cards/#{flight_card.id}"
        }.to_not change { FlightCard.count }
        expect(response).to redirect_to launch_flight_cards_path(launch.id)
      end
    end
  end
end
