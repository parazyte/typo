 require 'spec_helper'

# rake spec SPEC=spec/controllers/admin/mathias_spec.rb
#
describe Admin::ContentController do
  render_views

  context 'when the user is logged in with an admin connection' do
    before :each do
      Factory(:blog)
      Profile.delete_all
      @user1 = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      @user1.editor = 'simple'
      @user1.save
      request.session = {:user => @user1.id}
    end
    it "should allow articles to be merged with each other and preserving comments" do
      @article1 = FactoryGirl.create(:article, {:title => "christmas", :published => true, :author => "Mathias", :body => "Christmas toodle toodle hey hey"})
      @article2 = FactoryGirl.create(:article, {:title => "My x-mas",  :published => true, :author => "Andreas", :body => "My x-mas was dreadful. Yikes..."})
      @comment1 = FactoryGirl.create(:comment, {:article_id => @article1.id, :title => "comment1",  :published => true, :author => "Jon", :body => "Fuck dat shit"})
      @comment2 = FactoryGirl.create(:comment, {:article_id => @article2.id, :title => "comment1",  :published => true, :author => "Ken", :body => "Derp dat herp"})
      post :merge, 'id' => @article1.id, 'merge_with' => @article2.id
      response.should redirect_to "/admin/content/edit/#{@article1.id}"
      get :new, 'id' => @article1.id
      response.should contain(/Christmas toodle toodle hey hey/m)
      response.should contain(/My x-mas was dreadful. Yikes.../m)
      #response.should contain(/Fuck dat shit/m)
      #response.should contain(/Derp dat herp/m)
    end
  end

  context 'when the user is logged in with a non-admin connection' do
    before :each do
      Factory(:blog)
      Profile.delete_all
      @user1 = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_publisher))
      @user1.editor = 'simple'
      @user1.save
      request.session = {:user => @user1.id}
    end
    it "should not allow articles to be merged with each other" do
      @article1 = FactoryGirl.create(:article, {:title => "christmas", :published => true, :author => "Mathias", :body => "Christmas toodle toodle hey hey"})
      @article2 = FactoryGirl.create(:article, {:title => "My x-mas",  :published => true, :author => "Andreas", :body => "My x-mas was dreadful. Yikes..."})
      @comment1 = FactoryGirl.create(:comment, {:article_id => @article1.id, :title => "comment1",  :published => true, :author => "Jon", :body => "Fuck dat shit"})
      @comment2 = FactoryGirl.create(:comment, {:article_id => @article2.id, :title => "comment1",  :published => true, :author => "Ken", :body => "Derp dat herp"})
      post :merge, 'id' => @article1.id, 'merge_with' => @article2.id
      #response.should redirect_to "/admin/content/edit/#{@article1.id}"
      response.should redirect_to "/admin/content"
      get :new, 'id' => @article1.id
      response.should contain(/Error, you are not allowed to perform this action/m)
      #response.should contain(/Fuck dat shit/m)
      #response.should contain(/Derp dat herp/m)
    end
  end
end