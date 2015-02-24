# Helpers that are automatically included in spec/requests/**/*_spec.rb
module RequestHelpers
  # Provides response body as ruby hash
  def response_json
    @response_json ||= JSON.parse(response.body)
  end
  # Sends get request as authorized user
  # @param path <String> Path to send request to.
  # @param user_credentials {:email => String, :access_token => String} User to make request as's email and access token
  def get_as(path, user_credentials)
    credentials_string = "#{ user_credentials[:email] }:#{ user_credentials[:access_token] }"
    headers = {
      "HTTP_AUTHORIZATION" => Base64.encode64(credentials_string) }
    get(path, {}, headers)
  end

  # Post as authorized user with form parameters
  # @param path <String> Path to send request to.
  # @param user_credentials {:email => String, :access_token => String}
  def post_as(path, user_credentials, params)
    credentials_string = "#{ user_credentials[:email] }:#{ user_credentials[:access_token] }"
    headers = { "HTTP_AUTHORIZATION" => Base64.encode64(credentials_string) }

    post(path, params, headers)
  end
end
