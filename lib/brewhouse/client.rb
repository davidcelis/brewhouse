require 'net/http'
require 'cgi'
require 'json'

module Brewhouse
  class Client
    class Error < RuntimeError
      attr_reader :response

      def initialize(response)
        @response, @json = response, JSON.parse(response.body)
      end

      def body()    @json                  end
      def message() body['errorMessage']   end
      alias :error :message
    end

    class Response
      def initialize(response)
        @response = response
      end

      def body
        @body ||= API::Remapper.prettify(JSON.parse(@response.body))
      end
    end

    CONTENT_TYPE = 'application/json'
    METHODS = {
      :get    => Net::HTTP::Get,
      :post   => Net::HTTP::Post,
      :put    => Net::HTTP::Put,
      :delete => Net::HTTP::Delete
    }
    HOST = 'api.brewerydb.com'
    BASE_PATH = '/v2'
    PORT = 80

    def initialize(api_key = nil)
      @api_key = api_key || Brewhouse.config.api_key
    end

    def get(path, params = {}, options = {})
      request :get, path, options.merge(:params => params)
    end

    def post(path, body = nil, options = {})
      request :post, path, options.merge(:body => body)
    end

    def put(path, body = nil, options = {})
      request :put, path, options.merge(:body => body)
    end

    def delete(path, options = {})
      request :delete, path, options
    end

    private

    def request(method, path, options)
      path += "?key=#{@api_key}"

      if params = options[:params] and !params.empty?
        params = Brewhouse::API::Remapper.uglify(params)
        q = params.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }
        path += "&#{q.join('&')}"
      end

      req = METHODS[method].new(BASE_PATH + path, 'Accept' => CONTENT_TYPE)

      if options.key?(:body)
        req['Content-Type'] = CONTENT_TYPE
        req.body = options[:body] ? JSON.dump(options[:body]) : ''
      end

      http = Net::HTTP.new HOST, PORT

      res = http.start { http.request(req) }

      case res
      when Net::HTTPSuccess
        return Response.new(res)
      else
        raise Error, res
      end
    end
  end
end
