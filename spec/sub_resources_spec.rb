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
      url_by_name('book_tags', :id => 3).should ==
        '/books/3/tags'
      @set.recognize_path("/books/3/tags", :method => :get).should ==
        {:controller => 'books', :action => 'tags', :id => '3'}
    end

    it "POST 'books/3/tags' should be mapped BookScontroller#create_tag" do
      @set.recognize_path("/books/3/tags", :method => :post).should ==
        {:controller => 'books', :action => 'create_tag', :id => '3'}
    end

    it "GET 'books/3/tag/1' should be mapped BookScontroller#tag" do
      url_by_name('book_tag', :id => 3, :tag_id => 1).should ==
        '/books/3/tags/1'
      @set.recognize_path("/books/3/tags/1", :method => :get).should ==
        {:controller => 'books', :action => 'tag', :id => '3', :tag_id => '1'}
    end

    it "PUT 'books/3/tag/1' should be mapped BookScontroller#update_tag" do
      @set.recognize_path("/books/3/tags/1", :method => :put).should ==
        {:controller => 'books', :action => 'update_tag', :id => '3', :tag_id => '1'}
    end

    it "DELETE 'books/3/tag/1' should be mapped BookScontroller#destroy_tag" do
      @set.recognize_path("/books/3/tags/1", :method => :delete).should ==
        {:controller => 'books', :action => 'destroy_tag', :id => '3', :tag_id => '1'}
    end

    it "GET 'books/3/tags/new' should be mapped BookScontroller#new_tag" do
      url_by_name('new_book_tag', :id => 3).should ==
        '/books/3/tags/new'
      @set.recognize_path("/books/3/tags/new", :method => :get).should ==
        {:controller => 'books', :action => 'new_tag', :id => '3'}
    end

    it "GET 'books/3/tags/1/edit' should be mapped BookScontroller#edit_tag" do
      url_by_name('edit_book_tag', :id => 3, :tag_id => 1).should ==
        '/books/3/tags/1/edit'
      @set.recognize_path("/books/3/tags/1/edit", :method => :get).should ==
        {:controller => 'books', :action => 'edit_tag', :id => '3', :tag_id => '1'}
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
      url_by_name('book_tag', :id => 3, :tag_id => 1).should ==
        '/books/3/tags/1'
      @set.recognize_path("/books/3/tags/1", :method => :get).should ==
        {:controller => 'books', :action => 'tag', :id => '3', :tag_id => '1'}
    end
  end
  describe "books - tags using hash" do
    before do
      ActionController::Routing.use_controllers! ['books', 'tags']
      @set = ActionController::Routing::RouteSet.new
      @set.draw do |map|
        map.resources :books, :sub_resources => {
          :tags => {
            :only => :show,
            :member => {:vote => :post}
        }}
      end
    end
    it "GET 'books/3/tags/1' should be mapped BookScontroller#tag" do
      url_by_name('book_tag', :id => 3, :tag_id => 1).should ==
        '/books/3/tags/1'
      @set.recognize_path("/books/3/tags/1", :method => :get).should ==
        {:controller => 'books', :action => 'tag', :id => '3', :tag_id => '1'}
    end
    it "DELETE 'books/3/tag/1' should not be mapped" do
      lambda{@set.recognize_path "/books/3/tags/1", :method => :delete}.should raise_error
    end
    it "POST 'books/3/tags/1/vote" do
      url_by_name('vote_book_tag', :id => 3, :tag_id => 7).should ==
        '/books/3/tags/7/vote'
      @set.recognize_path("/books/3/tags/1/vote", :method => :post).should ==
        {:controller => 'books', :action => 'vote_tag', :id => '3', :tag_id => '1'}
    end
  end

  private
  def url_by_name(name, options)
    @set.generate(options.merge(:use_route => name))
  end
end