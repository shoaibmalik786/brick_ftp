require "rack/test"
RSpec.describe 'Brickftp::Upload' do
  it "Upload file to brick_ftp #create" do
    file = Rack::Test::UploadedFile.new("spec/data/test.txt")
    res = Brickftp::Upload.create(path: "#{file.original_filename}", source: file)
    expect(file.original_filename).to eq res['path']
  end  
end
