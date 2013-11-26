require 'spec_helper'

describe CategoriesController do

  let(:category) { create(:category) }
  before(:each) { login_admin }

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it "assigns sorted list of categories to @categories" do
      get :index
      expect(assigns(:categories)).to eq Category.sorted
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: category.id
      expect(response).to be_success
    end

    it "assigns requested category to @category" do
      get :show, id: category.id
      expect(assigns(:category)).to eq category
    end

    it "renders the show template" do
      get :show, id: category.id
      expect(response).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "assigns a new category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST 'create'" do

    context "with valid attributes" do
      it "saves the new category in the database" do
        expect {
          post :create, category: attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it "redirects to all categories page" do 
        post :create, category: attributes_for(:category)
        expect(response).to redirect_to categories_path
      end
    end

    context "with in-valid attributes" do
      it "does not save the new category in the database" do
        expect {
          post :create, category: attributes_for(:invalid_category)
        }.to_not change(Category, :count).by(1)
      end

      it "re-renders the :new template" do
        post :create, category: attributes_for(:invalid_category)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do
    let(:category) { create(:category) }

    it "returns http success" do
      get :edit, id: category.id
      expect(response).to be_success
    end

    it "assigns the requested category to @category" do
      get :edit, id: category.id
      expect(assigns(:category)).to eq category
    end

    it "renders the :edit template" do
      get :edit, id: category.id
      expect(response).to render_template :edit
    end
  end

  describe "PATCH 'update'" do

    let(:category) { create(:category, name: "Test Category") }

    context "valid attributes" do
      it "located the requested @category" do
        patch :update, id: category.id, category: attributes_for(:category)
        expect(assigns(:category)).to eq(category)
      end

      it "changes @category attributes" do
        patch :update, id: category.id, category: attributes_for(:category,
          name: "Different Category")
        category.reload
        expect(category.name).to eq("Different Category")
      end

      it "redirects to all categories page" do
        patch :update, id: category.id, category: attributes_for(:category)
        expect(response).to redirect_to categories_path
      end
    end

    context "invalid attributes" do
      it "does not change the category's attributes" do
        patch :update, id: category.id, category: attributes_for(:category,
          name: nil)
        category.reload
        expect(category.name).to eq("Test Category")
      end

      it "re-renders the edit template" do
        patch :update, id: category.id, category: attributes_for(:invalid_category)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do

    let!(:category) { create(:category) }

    it "deletes the category" do
      expect {
        delete :destroy, id: category.id
      }.to change(Category, :count).by(-1)
    end

    it "redirects to all categories page" do
      delete :destroy, id: category.id
      expect(response).to redirect_to categories_path
    end
  end

end
