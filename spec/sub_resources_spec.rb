require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'SubResources' do

  describe "books - tags using simbol" do
    before do
      ActionController::Routing.use_controllers! ['books', 'tags']
      @set = ActionController::Routing::RouteSet.new
      @set.draw do |map|
        map.resources :books, :sub_resources => :tags
      end
    end
    
    it "GET 'books/3/tags' should be mapped BooksController#tags" do
      r = @set.recognize_path "/books/3/tags", :method => :get
      r[:controller].should == 'books'
      r[:action].should == 'tags'
      r[:id].should == '3'
    end

    it "POST 'books/3/tags' should be mapped BookScontroller#create_tag" do
      r = @set.recognize_path "/books/3/tags", :method => :post
      r[:controller].should == 'books'
      r[:action].should == 'create_tag'
      r[:id].should == '3'
    end

    it "GET 'books/3/tag/1' should be mapped BookScontroller#tag" do
      r = @set.recognize_path "/books/3/tags/1", :method => :get
      r[:controller].should == 'books'
      r[:action].should == 'tag'
      r[:id].should == '3'
      r[:tag_id].should == '1'
    end

    it "PUT 'books/3/tag/1' should be mapped BookScontroller#update_tag" do
      r = @set.recognize_path "/books/3/tags/1", :method => :put
      r[:controller].should == 'books'
      r[:action].should == 'update_tag'
      r[:id].should == '3'
      r[:tag_id].should == '1'
    end

    it "DELETE 'books/3/tag/1' should be mapped BookScontroller#destroy_tag" do
      r = @set.recognize_path "/books/3/tags/1", :method => :delete
      r[:controller].should == 'books'
      r[:action].should == 'destroy_tag'
      r[:id].should == '3'
      r[:tag_id].should == '1'
    end

    it "GET 'books/3/tags/new' should be mapped BookScontroller#new_tag" do
      r = @set.recognize_path "/books/3/tags/new", :method => :get
      r[:controller].should == 'books'
      r[:action].should == 'new_tag'
      r[:id].should == '3'
    end

    it "GET 'books/3/tags/1/edit' should be mapped BookScontroller#edit_tag" do
      r = @set.recognize_path "/books/3/tags/1/edit", :method => :get
      r[:controller].should == 'books'
      r[:action].should == 'edit_tag'
      r[:id].should == '3'
      r[:tag_id].should == '1'
    end
  end
  describe "books - tags using array" do
    before do
      ActionController::Routing.use_controllers! ['books', 'tags']
      @set = ActionController::Routing::RouteSet.new
      @set.draw do |map|
        map.resources :books, :sub_resources => [:tags]
      end
    end
    it "GET 'books/3/tag/1' should be mapped BookScontroller#tag" do
      r = @set.recognize_path "/books/3/tags/1", :method => :get
      r[:controller].should == 'books'
      r[:action].should == 'tag'
      r[:id].should == '3'
      r[:tag_id].should == '1'
    end
  end
  describe "books - tags using hash" do
    before do
      ActionController::Routing.use_controllers! ['books', 'tags']
      @set = ActionController::Routing::RouteSet.new
      @set.draw do |map|
        map.resources :books, :sub_resources => {:tags => {:only => :show,
         }}
      end
    end
    it "GET 'books/3/tag/1' should be mapped BookScontroller#tag" do
      r = @set.recognize_path "/books/3/tags/1", :method => :get
      r[:controller].should == 'books'
      r[:action].should == 'tag'
      r[:id].should == '3'
      r[:tag_id].should == '1'
    end
    it "DELETE 'books/3/tag/1' should not be mapped" do
      lambda{@set.recognize_path "/books/3/tags/1", :method => :delete}.should raise_error
    end
  end

end