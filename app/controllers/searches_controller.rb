class SearchesController < ApplicationController

  def new
  end

  def show
    search_term = params['q'].capitalize
    response = RestClient.get  "https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.search.collection&access_token=2ace9111870766f9c7c85139cb811d58&medium=#{search_term}&page=1&per_page=100"
    json = JSON.parse response
    if !json['total'].zero?
      @object1link = json["objects"][0]["images"][0]["b"]["url"]
      @object1title = json["objects"][0]["title"]
      @objects = json["objects"]
    else
      render :new
    end
  end

end
