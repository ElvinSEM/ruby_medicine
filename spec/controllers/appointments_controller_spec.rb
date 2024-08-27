require 'rails_helper'
require 'telegram/bot'

RSpec.describe AppointmentsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    ActiveJob::Base.queue_adapter = :test
  end
  let(:user) { create(:user, telegram_chat_id: '123456789') } # добавили telegram_chat_id
  let(:doctor) { create(:doctor) }
  let(:valid_attributes) {
    {
      start_time: Time.current + 1.day,
      doctor_id: doctor.id,
      user_id: user.id,
      problem_id: 1
    }
  }
  let(:invalid_attributes) { { start_time: nil, doctor_id: nil } }

  before do
    sign_in user
    allow(ReminderJob).to receive(:perform_later)
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Appointment" do
        expect {
          post :create, params: { appointment: valid_attributes }
        }.to change(Appointment, :count).by(1)
      end

      it "redirects to the created appointment" do
        post :create, params: { appointment: valid_attributes }
        expect(response).to redirect_to(Appointment.last)
      end

      it "does not send a Telegram message if user does not have telegram_chat_id" do
        user.update(telegram_chat_id: nil)
        allow(Rails.logger).to receive(:info)
        expect(Telegram::Bot::Client).not_to receive(:new)

        post :create, params: { appointment: valid_attributes }

        expect(Rails.logger).to have_received(:info).with("Пользователь #{user.id} не имеет telegram_chat_id, сообщение не отправлено.")
      end


      it 'schedules a reminder' do
        expect {
          post :create, params: valid_params
        }.to have_enqueued_job(ReminderJob).with(kind_of(Integer))
        end
    context "with invalid parameters" do
      it "does not create a new Appointment" do
        expect {
          post :create, params: { appointment: invalid_attributes }
        }.not_to change(Appointment, :count)
      end

      it "renders a new template with an error" do
        post :create, params: { appointment: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all user's appointments as @appointments" do
      appointment = create(:appointment, user: user, start_time: Time.current + 2.days)
      get :index
      expect(assigns(:appointments)).to eq([appointment])
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested appointment" do
      appointment = create(:appointment, user: user, start_time: Time.current + 2.days)
      expect {
        delete :destroy, params: { id: appointment.to_param }
      }.to change(Appointment, :count).by(-1)
    end

    it "redirects to the appointments list" do
      appointment = create(:appointment, user: user, start_time: Time.current + 2.days)
      delete :destroy, params: { id: appointment.to_param }
      expect(response).to redirect_to(appointments_url)
    end
  end
 end
end