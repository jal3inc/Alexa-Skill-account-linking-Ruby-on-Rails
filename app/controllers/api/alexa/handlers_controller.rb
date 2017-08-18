class Api::Alexa::HandlersController < ActionController::Base
  prepend_before_action :set_access_token_in_params
  before_action :doorkeeper_authorize!
  respond_to :json

  def create
    user = current_doorkeeper_user
    intent_name = params["request"]["intent"]["name"]
    case intent_name
    when "insert-intent-name-here"
     
      message = "Hello world response 1!"
      render response_with_message(message)
    when "insert-intent-name-here"
      
      message = "Hello world response 2!"
      render response_with_message(message)
    else
      #error somehow
      render response_with_message("Error. We couldn't find your request")
    end
  end

  def current_doorkeeper_user
    @current_doorkeeper_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  private

  def response_with_message(message)
    {
      json: {
        "response": {
          "outputSpeech": {
            "type": "PlainText",
            "text": message,
          },
          "shouldEndSession": true
        },
        "sessionAttributes": {}
      }
    }
  end

  def set_access_token_in_params
    request.parameters[:access_token] = token_from_params
  end

  def token_from_params
    params["session"]["user"]["accessToken"] rescue nil
  end
end