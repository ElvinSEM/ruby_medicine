require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @doctors" do
      doctor = FactoryBot.create(:doctor)
      get :index
      expect(assigns(:doctors)).to eq([doctor])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      doctor = FactoryBot.create(:doctor)
      get :show, params: { id: doctor.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested doctor to @doctor" do
      doctor = FactoryBot.create(:doctor)
      get :show, params: { id: doctor.id }
      expect(assigns(:doctor)).to eq(doctor)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns a new doctor to @doctor" do
      get :new
      expect(assigns(:doctor)).to be_a_new(Doctor)
    end
  end

  describe "POST #create" do
    it "creates a new doctor" do
      expect {
        post :create, params: { doctor: FactoryBot.attributes_for(:doctor) }
      }.to change(Doctor, :count).by(1)
    end

    it "redirects to the created doctor" do
      post :create, params: { doctor: FactoryBot.attributes_for(:doctor) }
      expect(response).to redirect_to(Doctor.last)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      doctor = FactoryBot.create(:doctor)
      get :edit, params: { id: doctor.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested doctor to @doctor" do
      doctor = FactoryBot.create(:doctor)
      get :edit, params: { id: doctor.id }
      expect(assigns(:doctor)).to eq(doctor)
    end
  end

  describe "PUT #update" do
    it "updates the requested doctor" do
      doctor = FactoryBot.create(:doctor)
      put :update, params: { id: doctor.id, doctor: { name: "New Name" } }
      doctor.reload
      expect(doctor.name).to eq("New Name")
    end

    it "redirects to the updated doctor" do
      doctor = FactoryBot.create(:doctor)
      put :update, params: { id: doctor.id, doctor: { name: "New Name" } }
      expect(response).to redirect_to(doctor)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested doctor" do
      doctor = FactoryBot.create(:doctor)
      expect {
        delete :destroy, params: { id: doctor.id }
      }.to change(Doctor, :count).by(-1)
    end

    it "redirects to the doctors list" do
      doctor = FactoryBot.create(:doctor)
      delete :destroy, params: { id: doctor.id }
      expect(response).to redirect_to(doctors_url)
    end
  end
end
