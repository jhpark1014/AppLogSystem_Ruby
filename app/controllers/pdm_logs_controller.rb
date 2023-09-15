require 'httparty'
require 'pg'
require 'dotenv/load'
require 'json'

class PdmLogsController < ApplicationController
  def index
  end

  def establish_db_connection
    begin
      connection = PG.connect(
        dbname: ENV['DB_DATABASE'],
        user: ENV['DB_USERNAME'],
        password: ENV['DB_PASSWORD'],
        host: ENV['DB_SERVER'],
        port: ENV['DB_PORT']
      )
      yield connection  # Yield the connection to a block
    ensure
      connection.close if connection
    end
  end

  def get_result_data(tablename, values)
    establish_db_connection do |db|  
      begin
        # connection.exec("SET search_path TO public") # Set the schema if necessary
    
        # Prepare the SQL statement with placeholders for input parameters
        sql = "SELECT #{tablename}("
        values.each_with_index do |v, index|
          sql += "$#{index + 1},"
        end
        sql.chomp!(',') # Remove the trailing comma
        sql += ")"
    
        # Execute the SQL statement with input parameters
        result = db.exec_params(sql, values.map { |v| v[:value] })
    
        # Process the result and return data
        result_data = {
          data: result.to_a,
        }
    
        return result_data
      # ensure
      #   db.close if db
      end
    end
  end
 
  def download
    # result_response = HTTParty.post('http://localhost:9900/logs/download',
    #                                 body: {
    #                                   log_type: 'download',
    #                                   search_type: 'month',
    #                                   search_date: '2023-07',
    #                                   user_id: 'All',
    #                                   exc_user_id: ''
    #                                 }.to_json,
    #                                 headers: { 'Content-Type' => 'application/json' })

    # @result_data = JSON.parse(result_response.body)

    # user_list_response = HTTParty.post('http://localhost:9900/logs/userlist',
    #                                    body: {
    #                                      log_type: 'download',
    #                                      search_type: 'month',
    #                                      search_date: '2023-07',
    #                                      exc_user_id: ''
    #                                    }.to_json,
    #                                    headers: { 'Content-Type' => 'application/json' })

    # @user_data = JSON.parse(user_list_response.body)

    connection = ActiveRecord::Base.connection
    str = "SELECT public.\"SP_LOGIN_LOG_LICENSE_FUNCTION\"('month', '2023-08', 'swepdm_cadeditorandweb', '', '');"
    # str = "CALL \"SP_LOGIN_LOG_LICENSE\"('month', '2023-09', '', '', '')";
    # str_function = "SELECT \"getParameters\"('month', '2023-08');"
    # str_function = "SELECT \"getParameters\"('year', '2023');"

    @result = connection.execute(str)
    # result_fn = connection.execute(str_function)

    @data = @result
    # @data_fn = result_fn.to_json

    # Example usage
    tablename = "public.\"SP_LOGIN_LOG_LICENSE_FUNCTION\""
    values = [
      { key: 'search_type', value: 'month' },
      { key: 'search_date', value: '2023-09' },
      { key: 'lic_id', value: 'swepdm_cadeditorandweb' },
      { key: 'exc_lic_id', value: '' },
      { key: 'exc_user_id', value: '' }
    ]

    @result_data = get_result_data(tablename, values)

    @json2_array = []
    @result_data.each do |row|
      
    # @json_array = result_data[:data]

    # @json_array_parse = JSON.parse(@result_data)


    # @json_array.each do |item|
    #   @json2_array.push(item["SP_LOGIN_LOG_LICENSE_FUNCTION"])
    # end

    # @data_array_without_quotes = @json2_array.map { |item| item.gsub('"', '') }

    # Now, data_array_without_quotes contains items without double quotes
    # puts data_array_without_quotes.inspect

    @json3_array = []

    @result_data_json = @result_data.to_json
    puts 'result_data:::', @result_data.to_json

    render 'download'
  end
end

  def newcreate
    @response = HTTParty.post('http://localhost:9900/logs/newcreate',
                              body: {
                                log_type: 'newcreate',
                                search_type: 'month',
                                search_date: '2023-07',
                                user_id: 'All',
                                exc_user_id: ''
                              }.to_json,
                              headers: { 'Content-Type' => 'application/json' })

    @data = JSON.parse(response.body)
  end

  def versionup
    @response = HTTParty.post('http://localhost:9900/logs/versionup',
                              body: {
                                log_type: 'versionup',
                                search_type: 'month',
                                search_date: '2023-07',
                                user_id: 'All',
                                exc_user_id: ''
                              }.to_json,
                              headers: { 'Content-Type' => 'application/json' })

    @data = JSON.parse(response.body)
  end

  def engchange
    @response = HTTParty.post('http://localhost:9900/logs/engchange',
                              body: {
                                log_type: 'engchange',
                                search_type: 'month',
                                search_date: '2023-07',
                                user_id: 'All',
                                exc_user_id: ''
                              }.to_json,
                              headers: { 'Content-Type' => 'application/json' })

    @data = JSON.parse(response.body)
  end
end
