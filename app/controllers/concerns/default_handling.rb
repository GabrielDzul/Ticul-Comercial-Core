module DefaultHandling
  def self.included(cls)
    cls.class_eval do

      # must go first in order to preserve last priority
      # https://stackoverflow.com/a/9121054/3287738
      rescue_from StandardError do |e|
        report_error(e, notify: true)
        respond Error::InternalServerError.new
      end

      rescue_from ActionDispatch::Http::Parameters::ParseError do |e|
        report_error(e, notify: false)
        respond Error::BadRequest.new
      end

      rescue_from Error::Base do |e|
        report_error(e, notify: e.is_a?(Error::InternalServerError))
        respond e
      end
    end
  end

  def respond(error)
    render json: error,
           status: error.status,
           serializer: APIErrorSerializer,
           adapter: :json,
           root: 'error'
  end

  def report_error(err, notify: false)
    print_trace(err)
    #notify_bugsnag(err) if notify
  end
end
