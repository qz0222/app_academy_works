require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "Get #new" do
    it "renders the 'new' view" do
      get :new, link: {}
      expect(response).to render_template("new")
    end
  end

  describe "Post #create" do
    context "with valid params" do
      before(:each) do
        @num_users = User.all.count
        post :create, user:{username: 'test', password: 'qwerty'}
      end

      it "renders the 'show' view" do
        expect(response).to render_template("show")
      end

      context "create a new user" do
        it "create one new user" do
          expect(User.all.count).to eq(@num_users + 1)
        end

        it "with given params" do
          expect(User.find_by(username: 'test')).to eq(User.last)
        end
      end

    end

    context "with invalid params" do
      let(:num_users){ User.all.count}
      before(:each) do
        post :create, user:{name:"", password:""}
      end

      it "shouldn't add to the db" do
        expect(User.all.count).to eq(num_users)
      end

      it "should redirect to the 'new' action" do
        expect(response).to redirect_to(new_user_url)
      end

      it "should create flash errors" do
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "Get #show" do

    before{ get :show, {id:1} }

    it do
      should render_template('show')
    end



  end
end
