module Tlab
  class Post < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :history

    validates :slug, presence: true
    attr_accessor :author_name
    belongs_to :author, class_name: Tlab.author_class

    scope :most_recent, -> { order("published_at desc").first(3) }

    def next
      future_posts.first
    end

    def prev
      past_posts.first
    end

    private
    def future_posts
      Tlab::Post.where("published_at > ?", [published_at]).order("published_at asc")
    end

    def past_posts
      Tlab::Post.where("published_at < ?", [published_at]).order("published_at desc")
    end
  end
end
