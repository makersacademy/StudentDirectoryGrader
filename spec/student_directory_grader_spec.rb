require 'net/http'
require 'json'
require 'base64'

describe 'StudentDirectory Project' do

  STUDENT_GITHUB_LOGIN = 'ananogal'
  REPO_URL = "https://api.github.com/repos/#{STUDENT_GITHUB_LOGIN}/student-directory"

  it 'should exist in a repo' do 
    uri = URI(REPO_URL)
    str = Net::HTTP.get(uri)
    hash = JSON.parse(str) 
    expect(hash['message']).not_to eq 'not found'
  end

  it 'should include a readme' do 
    uri = URI(REPO_URL+'/readme')
    str = Net::HTTP.get(uri) 
    readme = Base64.decode64 JSON.parse(str)['content']
    expect(readme).not_to be_nil
  end

  it 'should not smell' do
    uri = URI(REPO_URL+'/contents/directory.rb')
    str = Net::HTTP.get(uri) 
    student_code = Base64.decode64 JSON.parse(str)['content']
    expect(student_code).not_to reek
  end

end