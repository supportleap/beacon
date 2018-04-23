ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'
require 'chatops/controller/test_case'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def execute_query(query, variables: {}, context: {})
    variables = variables.map { |k, v| [k.to_s, v] }.to_h

    Graph.execute(query, variables: variables, context: context)
  end
end
