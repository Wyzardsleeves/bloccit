require 'rails_helper'
include RandomData  #temp
include SessionsHelper #temp

RSpec.describe TopicsController, type: :controller do
  #let(:my_topic){Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:my_topic){create(:topic)}

  context "guest" do
    describe "GET index" do
      it "returns http-success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns my_topic to @topics" do
        get :index
        expect(assigns(:topics)).to eq([my_topic])
      end
    end #describe "GET index"

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_topic.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_topic.id}
        expect(response).to render_template :show
      end
      it "assigns my_topic to @topic" do
        get :show, {id: my_topic.id}
        expect(assigns(:topic)).to eq(my_topic)
      end
    end #describe "GET show"

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "GET new"

    describe "POST create" do
      it "returns http redirect" do
        post :create, topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "POST create"

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, {id: my_topic.id}
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, {id: my_topic.id}
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "DELETE destroy"
  end #context "guest"

  context "member user" do
    before do
      user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :member)
      create_session(user)
    end

    describe "GET index" do
      it "returns http-success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns my_topic to @topics" do
        get :index
        expect(assigns(:topics)).to eq([my_topic])
      end
    end #describe "GET index"

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_topic.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_topic.id}
        expect(response).to render_template :show
      end
      it "assigns my_topic to @topic" do
        get :show, {id: my_topic.id}
        expect(assigns(:topic)).to eq(my_topic)
      end
    end #describe "GET show"

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to redirect_to(topics_path)
      end
    end #describe "GET new"

    describe "POST create" do
      it "increases the number of topics by 1" do
        post :create, topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(topics_path)
      end
    end #describe "POST create"

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_topic.id}
        expect(response).to redirect_to(topics_path)
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        expect(response).to redirect_to(topics_path)
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, {id: my_topic.id}
        expect(response).to redirect_to(topics_path)
      end
    end #describe "DELETE destroy"
  end #context "member user"

  context "admin user" do
    before do
      user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :admin)
      create_session(user)
    end
    describe "GET index" do
      it "returns http-success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns my_topic to @topics" do
        get :index
        expect(assigns(:topics)).to eq([my_topic])
      end
    end #describe "GET index"

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_topic.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_topic.id}
        expect(response).to render_template :show
      end
      it "assigns my_topic to @topic" do
        get :show, {id: my_topic.id}
        expect(assigns(:topic)).to eq(my_topic)
      end
    end #describe "GET show"

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end
      it "initializes @topic" do
        get :new
        expect(assigns(:topic)).not_to be_nil
      end
    end #describe "GET new"

    describe "POST create" do
      it "increases the number of topics by 1" do
        expect{post :create, topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}.to change(Topic,:count).by(1)
      end
      it "assigns Topic.last to @topic" do
        post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(assigns(:topic)).to eq Topic.last
      end
      it "redirects to the new topic" do
        post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(response).to redirect_to Topic.last
      end
    end #describe "POST create"

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_topic.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, {id: my_topic.id}
        expect(response).to render_template :edit
      end
      it "assigns topic to be updated to @topic" do
        get :edit, {id: my_topic.id}
        topic_instance = assigns(:topic)

        expect(topic_instance.id).to eq my_topic.id
        expect(topic_instance.name).to eq my_topic.name
        expect(topic_instance.description).to eq my_topic.description
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "updates topic with expected attributes" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}

        updated_topic = assigns(:topic)
        expect(updated_topic.id).to eq my_topic.id
        expect(updated_topic.name).to eq new_name
        expect(updated_topic.description).to eq new_description
      end
      it "redirects to the updated topic" do
        new_name= RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        expect(response).to redirect_to my_topic
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, {id: my_topic.id}
        count = Post.where({id: my_topic.id}).size
        expect(count).to eq 0
      end
      it "redirects to topics index" do
        delete :destroy, {id: my_topic.id}
        expect(response).to redirect_to topics_path
      end
    end #describe "DELETE destroy"
  end #context "admin user"
  #begining of assignment-28
  context "moderator user" do
    before do
      user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :moderator)
      create_session(user)
    end
    describe "GET #index" do
      it "returns http-success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns my_topic to @topics" do
        get :index
        expect(assigns(:topics)).to eq([my_topic])
      end
    end #describe "GET index"

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: my_topic.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_topic.id}
        expect(response).to render_template :show
      end
      it "assigns my_topic to @topic" do
        get :show, {id: my_topic.id}
        expect(assigns(:topic)).to eq(my_topic)
      end
    end #describe "GET show"

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to redirect_to(topics_path)
      end
    end #describe "GET new"

    describe "POST create" do
      it "increases the number of topics by 1" do
        post :create, topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(topics_path)
      end
    end #describe "POST create"

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {id: my_topic.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, {id: my_topic.id}
        expect(response).to render_template :edit
      end
      it "assigns topic to be updated to @topic" do
        get :edit, {id: my_topic.id}
        topic_instance = assigns(:topic)
        expect(topic_instance).to eq(my_topic)
=begin
        expect(topic_instance.id).to eq my_topic.id
        expect(topic_instance.name).to eq my_topic.name
        expect(topic_instance.description).to eq my_topic.description
=end
      end
    end #describe "GET edit"

    describe "PUT #update" do
      it "updates topic with expected attributes" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}

        updated_topic = assigns(:topic)
        expect(updated_topic.id).to eq my_topic.id
        expect(updated_topic.name).to eq new_name
        expect(updated_topic.description).to eq new_description
      end
      it "redirects to the updated topic" do
        new_name= RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        expect(response).to redirect_to my_topic
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, {id: my_topic.id}
        #expect(response).to redirect_to(new_session_path) old version
        expect(response).to redirect_to topics_path
      end
    end #describe "DELETE destroy"
  end #context "moderator user"
  #end of assignment-28
end #RSpec.describe TopicsController
