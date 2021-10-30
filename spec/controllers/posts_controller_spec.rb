require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    it "should render the index template" do
      #GIVEN
      #WHEN
      get(:index)
      #THEN
      expect(response).to(render_template(:index))
    end
  end

  describe "#new" do
    context "with signed in user" do
      before do
        session[:user_id] = FactoryBot.create(:user).id
      end

      it "should render the new template" do
        get(:new)
        expect(response).to(render_template(:new))
      end

      it "should set an instance variable with a new post" do
        get(:new)
        expect(assigns(:post)).to(be_a_new(Post))
      end
    end
  end

  describe "#create" do
    context "with user signed in" do
      before do
        session[:user_id] = FactoryBot.create(:user).id
      end

      context "with valid parameters" do
        it "should create a post in the db" do
          count_before = Post.count
          post(:create, params:{post: FactoryBot.attributes_for(:post)})
          count_after = Post.count
          expect(count_after).to(eq(count_before + 1))
        end
      end
    end
  end


end
