
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(params)
      if Source.find_by(identifier: source.identifier)
        status 403
        "identifier already exists"
      elsif source.save
        status 200
        body JSON.generate({:identifier=>source.identifier})
      else
        status 400
        body source.errors.full_messages.join(", ")
      end
    end

    not_found do
      erb :error
    end
  end
end
