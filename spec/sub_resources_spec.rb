require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'SubResources' do
  before do
#    ActionController::Base.optimise_named_routes = false
  end

  describe "books - tags using simbol" do
    before do
      ActionController::Routing.use_controllers! ['books', 'tags']
      @set = ActionController::Routing::RouteSet.new
      @set.draw do |map|
        map.resources :books, :sub_resources => :tags
      end
    end
    
    it "aaa" do
      p @set.recognize_path "/books/:id", :method => :get
#      p @set.inspect
#      p @set.methods
      puts @set.routes
#      p @set.recognize_path "/books/:id/tags"
    end
  end
  after do
    p 'after'
#    ActionController::Base.optimise_named_routes = true
  end

end