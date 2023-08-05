RSpec.shared_examples 'success api response' do |schema_path|
  it 'is correct' do
    is_expected.to have_http_status(:ok)
    is_expected.to match_response_schema(schema_path)
  end
end