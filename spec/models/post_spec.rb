require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validates" do
    it "requires a title" do
      #GIVEN
      post = Post.new(title: nil)
      #WHEN
      post.valid?
      #THEN
      expect(post.errors.messages).to(have_key(:title))
    end
  
    
    it "requires body" do
      post = FactoryBot.build(:post, body: nil)
      # post = Post.new(body: nil)
      post.valid?
      expect(post.errors.messages).to(have_key(:body))
    end

    it "should contain at leat 50 characters" do
      post = FactoryBot.build(:post, body: 'a')
      # post = Post.new(body: 'a')
      post.valid?
      expect(post.errors.messages).to(have_key(:body))
    end
    
  end

end
