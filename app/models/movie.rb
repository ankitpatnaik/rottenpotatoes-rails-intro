class Movie < ActiveRecord::Base
    def self.all_ratings #returns all ratings when called.
    ['G', 'PG', 'PG-13', 'R','NC-17']
    end
end
