# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module FlowrouteNumbersAndMessaging
  # MessagesController
  class MessagesController < BaseController
    @instance = MessagesController.new

    class << self
      attr_accessor :instance
    end

    def instance
      self.class.instance
    end

    # Retrieves a list of Message Detail Records (MDRs) within a specified date
    # range. Date and time is based on Coordinated Universal Time (UTC).
    # @param [DateTime] start_date Required parameter: The beginning date and
    # time, in UTC, on which to perform an MDR search. The DateTime can be
    # formatted as YYYY-MM-DDor YYYY-MM-DDTHH:mm:ss.SSZ.
    # @param [DateTime] end_date Optional parameter: The ending date and time,
    # in UTC, on which to perform an MDR search. The DateTime can be formatted
    # as YYYY-MM-DD or YYYY-MM-DDTHH:mm:ss.SSZ.
    # @param [Integer] limit Optional parameter: The number of MDRs to retrieve
    # at one time. You can set as high of a number as you want, but the number
    # cannot be negative and must be greater than 0 (zero).
    # @param [Integer] offset Optional parameter: The number of MDRs to skip
    # when performing a query. The number must be 0 (zero) or greater, but
    # cannot be negative.
    # @return Mixed response from the API call
    def get_look_up_a_set_of_messages(start_date,
                                      end_date = nil,
                                      limit = nil,
                                      offset = nil)
      # Prepare query url.
      _query_builder = Configuration.base_uri.dup
      _query_builder << '/v2.1/messages'
      _query_builder = APIHelper.append_url_with_query_parameters(
        _query_builder,
        {
          'start_date' => start_date,
          'end_date' => end_date,
          'limit' => limit,
          'offset' => offset
        },
        array_serialization: Configuration.array_serialization
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json'
      }

      # Prepare and execute HttpRequest.
      _request = @http_client.get(
        _query_url,
        headers: _headers
      )
      BasicAuth.apply(_request)
      _context = execute_request(_request)

      # Validate response against endpoint and global error codes.
      if _context.response.status_code == 401
        raise ErrorException.new(
          'Unauthorized – There was an issue with your API credentials.',
          _context
        )
      elsif _context.response.status_code == 404
        raise ErrorException.new(
          'The specified resource was not found',
          _context
        )
      end
      validate_response(_context)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_context.response.raw_body) unless
        _context.response.raw_body.nil? ||
        _context.response.raw_body.to_s.strip.empty?
      decoded
    end

    # Sends an SMS or MMS from a Flowroute long code or toll-free phone number
    # to another valid phone number.
    # @param [Message] body Required parameter: The SMS or MMS message to
    # send.
    # @return Mixed response from the API call
    def create_send_a_message(body)
      # Prepare query url.
      _query_builder = Configuration.base_uri.dup
      _query_builder << '/v2.1/messages'
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'content-type' => 'application/json; charset=utf-8'
      }

      # Prepare and execute HttpRequest.
      _request = @http_client.post(
        _query_url,
        headers: _headers,
        parameters: body.to_json
      )
      BasicAuth.apply(_request)
      _context = execute_request(_request)

      # Validate response against endpoint and global error codes.
      if _context.response.status_code == 401
        raise ErrorException.new(
          'Unauthorized – There was an issue with your API credentials.',
          _context
        )
      elsif _context.response.status_code == 403
        raise ErrorException.new(
          'Forbidden – You don\'t have permission to access this resource.',
          _context
        )
      elsif _context.response.status_code == 404
        raise ErrorException.new(
          'The specified resource was not found',
          _context
        )
      elsif _context.response.status_code == 422
        raise ErrorException.new(
          'Unprocessable Entity - You tried to enter an incorrect value.',
          _context
        )
      end
      validate_response(_context)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_context.response.raw_body) unless
        _context.response.raw_body.nil? ||
        _context.response.raw_body.to_s.strip.empty?
      decoded
    end

    # Searches for a specific message record ID and returns a Message Detail
    # Record (in MDR2 format).
    # @param [String] id Required parameter: The unique message detail record
    # identifier (MDR ID) of any message. When entering the MDR ID, the number
    # should include the mdr2- preface.
    # @return MDR2 response from the API call
    def get_look_up_a_message_detail_record(id)
      # Prepare query url.
      _query_builder = Configuration.base_uri.dup
      _query_builder << '/v2.1/messages/{id}'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'id' => id
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json'
      }

      # Prepare and execute HttpRequest.
      _request = @http_client.get(
        _query_url,
        headers: _headers
      )
      BasicAuth.apply(_request)
      _context = execute_request(_request)

      # Validate response against endpoint and global error codes.
      if _context.response.status_code == 401
        raise ErrorException.new(
          'Unauthorized – There was an issue with your API credentials.',
          _context
        )
      elsif _context.response.status_code == 404
        raise ErrorException.new(
          'The specified resource was not found',
          _context
        )
      end
      validate_response(_context)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_context.response.raw_body)
      MDR2.from_hash(decoded)
    end
  end
end
