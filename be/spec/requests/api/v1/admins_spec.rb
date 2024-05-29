require 'swagger_helper'
RSpec.describe 'api/v1/admin' do
  path '/api/v1/signup' do
    post 'Sign up' do
      tags 'Admins'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          name: { type: :string }
        },
        required: %w[email password name]
      }
      request_body_example value: { email: 'minh@gmail.com', password: '123456', name: 'Minh' }, name: 'basic', summary: 'Success Example'
      response 200, 'Sign up successfully' do
        schema type: :object, properties: {
          user: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string },
              name: { type: :string },
              password_digest: { type: :string },
              refresh_token: { type: :string },
              created_at: { type: :string },
              updated_at: { type: :string },
            },
            required: %w[id email name password_digest refresh_token created_at updated_at]
          }
        }
        let(:user) { { email: 'minh@gmail.com', password: '123456', name: 'Minh' } }
        run_test!
      end

      response 422, 'Sign up fail (validation error)' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string, value: 'Minh@gmail.com' },
                 name: { type: :string },
                 password_digest: { type: :string },
                 refresh_token: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
               },
               required: %w[id email name password_digest refresh_token created_at updated_at]
        Admin.create(email: 'minh2@gmail.com', password: '123456', name: 'Minh')
        let(:user) { { email: 'minh2@gmail.com', password: '123456', name: 'Minh' } }
        run_test!
      end
    end
  end

  path '/api/v1/signin' do
    post 'Login' do
      tags 'Admins'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      request_body_example value: { email: 'minh@gmail.com', password: '123456' }, name: 'basic', summary: 'Success Example'
      response 200, 'Login successfully' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 email: { type: :string },
                 name: { type: :string },
                 accessToken: { type: :string },
                 refreshToken: { type: :string },
               },
               required: %w[status email name accessToken refreshToken]
        let(:user) { { email: 'minh@gmail.com', password: '123456' } }
        run_test!
      end
    end
  end

  path '/api/v1/refresh' do
    post 'Refresh' do
      tags 'Admins'
      security [cookieAuth: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :refresh_token, in: :cookie, type: :string
      response 200, 'Refresh successfully' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 accessToken: { type: :string }
               },
               required: %w[status accessToken]
        let(:refresh_token) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MTc1NTUzODJ9.DDXAIbzVqSDWAA3RoD_jmrTR7GvyUnub2ya9_rP5aHc' }
        run_test!
      end
    end
  end
end
