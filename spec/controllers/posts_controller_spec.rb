require 'rails_helper'

#adds SessionsHelper so that create_session(user)method can bue used in spec
include SessionsHelper

RSpec.describe PostsController, type: :controller do
  let(:my_user){User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  let(:other_user){User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "helloworld", role: :member)}
  #updates how we create my_post so that it will belong to my_topic
  let(:my_topic){Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  #removes the index tests.Posts will no longer
  let(:my_post){my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user)}

  #adds a context for a guest(un_signed-in) user
  context "guest" do
    #defines the show tests, which allows guests to view post in Bloccit
    describe "GET show" do
      it "returns http success" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(assigns(:post)).to eq(my_post)
      end
    end #describe "GET show"
    #defines test for the other CRUD actions
    describe "GET new" do
      it "returns http redirect" do
        get :new, topic_id: my_topic.id
        #we expect guests to be redirected if they attempt to create, update, or delete a post
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "GET new"
    describe "POST create" do
       it "returns http redirect" do
         post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
         expect(response).to redirect_to(new_session_path)
       end
     end  #describe "POST create"
    describe "GET edit" do
      it "returns http redirect" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "GET edit"
    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to(new_session_path)
      end
    end #describe "PUT update"
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:redirect)
      end
    end #describe "DELETE destroy"
  end #context "guest user"

  context "member user doing CRUD on a post they don't own" do
    before do
      create_session(other_user)
    end

    describe "GET show" do
      it "returns http success" do
        #passing {id: my_post.id} to show as a parameter via params hash
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        #set to expect the response to return the show view using the render_template
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        #set to expect the post to equal my_post because we call show
        expect(assigns(:post)).to eq(my_post)
      end
    end #describe "GET show"

    #stuff that might need to be removed
    describe "GET new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      #expects PostsController#new to render the posts new view.
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      #expects the @post instance variable to be initalized by PostsController#new
      it "instantiates @post" do
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end #decribe "GET new"
    describe "POST create" do
      #updates the post :create request to include the id of the parent topic.
      it "increases the number of Post by 1" do
        #this was commented out for some reason
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end
      it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end #describe "POST create"

    describe "GET edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to([my_topic, my_post])
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the post" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end #describe "DELETE destroy"
  end #context "member user doing CRUD on a post they don't own"

  context "member user doing CRUD on a post they do own" do
    before do
      create_session(my_user)
    end

    describe "GET show" do
      it "returns http success" do
        #passing {id: my_post.id} to show as a parameter via params hash
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        #set to expect the response to return the show view using the render_template
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        #set to expect the post to equal my_post because we call show
        expect(assigns(:post)).to eq(my_post)
      end
    end #describe "GET show"
    #stuff that might need to be removed
    describe "GET new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      #expects PostsController#new to render the posts new view.
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      #expects the @post instance variable to be initalized by PostsController#new
      it "instantiates @post" do
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end #decribe "GET new"
    describe "POST create" do
      #updates the post :create request to include the id of the parent topic.
      it "increases the number of Post by 1" do
        #this was commented out for some reason
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end
      it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end #describe "POST create"
#stuff end

    describe "GET edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        #expects the edit view to render when a post is edited
        expect(response).to render_template :edit
      end
      #tests that edit assigns the correct post to be updated to @post
      it "assigns post to be updated to @post" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        post_instance = assigns(:post)

        expect(post_instance.id).to eq my_post.id
        expect(post_instance.title).to eq my_post.title
        expect(post_instance.body).to eq my_post.body
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        #tests that @post was updated with tthe title and body passed to update
        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end
      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        #expects to be redirected to teh posts show veiw after the update
        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_topic, my_post]
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the post" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        #searches the database for a post with an id equal to my_post.id
        count = Post.where({id: my_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        #updates the delete :destroy request to include the id of the parent topic
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        #redirects to the topics show view instead of the posts index view
        expect(response).to redirect_to my_topic
      end
    end #describe "DELETE destroy"
  end #context "signed-in user"

  context "admin user doing CRUD on a post they don't own" do
    before do
      other_user.admin!
      create_session(other_user)
    end

    describe "GET show" do
      it "returns http success" do
        #passing {id: my_post.id} to show as a parameter via params hash
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        #set to expect the response to return the show view using the render_template
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        #set to expect the post to equal my_post because we call show
        expect(assigns(:post)).to eq(my_post)
      end
    end #describe "GET show"
    #stuff that might need to be removed
    describe "GET new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      #expects PostsController#new to render the posts new view.
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      #expects the @post instance variable to be initalized by PostsController#new
      it "instantiates @post" do
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end #decribe "GET new"
    describe "POST create" do
      #updates the post :create request to include the id of the parent topic.
      it "increases the number of Post by 1" do
        #this was commented out for some reason
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end
      it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end #describe "POST create"

    describe "GET edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        #expects the edit view to render when a post is edited
        expect(response).to render_template :edit
      end
      #tests that edit assigns the correct post to be updated to @post
      it "assigns post to be updated to @post" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        post_instance = assigns(:post)

        expect(post_instance.id).to eq my_post.id
        expect(post_instance.title).to eq my_post.title
        expect(post_instance.body).to eq my_post.body
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        #tests that @post was updated with tthe title and body passed to update
        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end
      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        #expects to be redirected to teh posts show veiw after the update
        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_topic, my_post]
      end
    end #describe "PUT update"

    describe "DELETE destroy" do
      it "deletes the post" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        #searches the database for a post with an id equal to my_post.id
        count = Post.where({id: my_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        #updates the delete :destroy request to include the id of the parent topic
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        #redirects to the topics show view instead of the posts index view
        expect(response).to redirect_to my_topic
      end
    end #describe "DELETE destroy"
  end #context "admin user doing CRUD on a post they don't own"

  #assignment-28
  context "moderator user doing CRUD on a post they don't own" do
    before do
      other_user.moderator!
      create_session(other_user)
    end

    describe "GET show" do
      it "returns http success" do
        #passing {id: my_post.id} to show as a parameter via params hash
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        #set to expect the response to return the show view using the render_template
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        #set to expect the post to equal my_post because we call show
        expect(assigns(:post)).to eq(my_post)
      end
    end #describe "GET show"
    #stuff that might need to be removed
    describe "GET new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      #expects PostsController#new to render the posts new view.
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      #expects the @post instance variable to be initalized by PostsController#new
      it "instantiates @post" do
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end #decribe "GET new"
    describe "POST create" do
      #updates the post :create request to include the id of the parent topic.
      it "increases the number of Post by 1" do
        #this was commented out for some reason
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end
      it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end #describe "POST create"

    describe "GET edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        #expects the edit view to render when a post is edited
        expect(response).to render_template :edit
      end
      #tests that edit assigns the correct post to be updated to @post
      it "assigns post to be updated to @post" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        post_instance = assigns(:post)

        expect(post_instance.id).to eq my_post.id
        expect(post_instance.title).to eq my_post.title
        expect(post_instance.body).to eq my_post.body
      end
    end #describe "GET edit"

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        #tests that @post was updated with tthe title and body passed to update
        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end
      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        #expects to be redirected to teh posts show veiw after the update
        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_topic, my_post]
      end
    end #describe "PUT update"

    describe "DELETE #destroy" do
      it "returns http redirect" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        # expect(response).to redirect_to([my_topic, my_post])
        expect(response).to redirect_to([my_topic, my_post]) #assignment-28
      end
    end #describe "DELETE destroy"
  end #context "moderator user doing CRUD on a post they don't own"

  context "moderator user doing CRUD on a post they do own" do
    before do
      other_user.moderator!
      create_session(my_user)
    end

    describe "GET #show" do
      it "returns http success" do
        #passing {id: my_post.id} to show as a parameter via params hash
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        #set to expect the response to return the show view using the render_template
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        #set to expect the post to equal my_post because we call show
        expect(assigns(:post)).to eq(my_post)
      end
    end #describe "GET show"
    #stuff that might need to be removed
    describe "GET #new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      #expects PostsController#new to render the posts new view.
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      #expects the @post instance variable to be initalized by PostsController#new
      it "instantiates @post" do
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end #decribe "GET new"
    describe "POST #create" do
      #updates the post :create request to include the id of the parent topic.
      it "increases the number of Post by 1" do
        #this was commented out for some reason
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end
      it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end #describe "POST create"

    describe "GET #edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        #expects the edit view to render when a post is edited
        expect(response).to render_template :edit
      end
      #tests that edit assigns the correct post to be updated to @post
      it "assigns post to be updated to @post" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        post_instance = assigns(:post)

        expect(post_instance.id).to eq my_post.id
        expect(post_instance.title).to eq my_post.title
        expect(post_instance.body).to eq my_post.body
      end
    end #describe "GET edit"

    describe "PUT #update" do
      it "updates post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        #tests that @post was updated with tthe title and body passed to update
        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end
      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_topic, my_post]
      end
    end #describe "PUT update"

    describe "DELETE #destroy" do
      it "deletes the post" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        count = Post.where({id: my_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        expect(response).to redirect_to(my_topic)
      end
    end #describe "DELETE destroy"
  end #context "moderator user doing CRUD on a post they do own"
  #assignment-28 end
end #RSpec describe PostController
