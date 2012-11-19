 require 'spec_helper'

# rake spec SPEC=spec/controllers/admin/mathias_spec.rb
#
describe Admin::ContentController do
  render_views
  
  describe 'with admin connection' do
    
    before :each do
      Factory(:blog)
      profile = Factory(:profile_publisher);
      @user1 = Factory(:user, :text_filter => Factory(:markdown), :profile => profile)
      #@user2 = Factory(:user, :text_filter => Factory(:markdown), :profile => profile)

      #@article1 = Factory(:article, {:user => @user1, :title => "christmas", :published => true, :author => "Mathias", :body => "Christmas toodle toodle hey hey"})
      #@article2 = Factory(:article, {:user => @user2, :title => "My x-mas",  :published => true, :author => "Andreas", :body => "My x-mas was dreadful. Yikes..."})
      
      request.session = {:user => @user1.id}
    end
      
    describe "article merge" do
      before do
        @article1 = FactoryGirl.create(:article, {:title => "christmas", :published => true, :author => "Mathias", :body => "Christmas toodle toodle hey hey"})
        @article2 = FactoryGirl.create(:article, {:title => "My x-mas",  :published => true, :author => "Andreas", :body => "My x-mas was dreadful. Yikes..."})
        @comment1 = FactoryGirl.create(:comment, {:article_id => @article1.id, :title => "comment1",  :published => true, :author => "Jon", :body => "Fuck dat shit"})
        @comment2 = FactoryGirl.create(:comment, {:article_id => @article2.id, :title => "comment1",  :published => true, :author => "Ken", :body => "Derp dat herp"})
      end
      
      it "should allow articles to be merged with each other and preserving comments" do
        post :merge, 'id' => @article1.id, 'merge_with' => @article2.id
        response.should redirect_to "/admin/content/edit/#{@article1.id}"
        get :new, 'id' => @article1.id
        response.should contain(/Christmas toodle toodle hey hey/m)
        response.should contain(/My x-mas was dreadful. Yikes.../m)
        #response.should contain(/Fuck dat shit/m)
        #response.should contain(/Derp dat herp/m)
      end
    end
  end
end

    
