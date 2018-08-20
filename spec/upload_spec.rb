require "rack/test"
RSpec.describe 'Brickftp::Upload' do
  it "Upload file to brick_ftp #create" do
    file = Rack::Test::UploadedFile.new("spec/data/test.txt")
    res = Brickftp::Upload.create(path: "#{file.original_filename}", source: file)
    expect(file.original_filename).to eq res['path']
  end

  it "file does not exist #create" do
    begin
      #file = Rack::Test::UploadedFile.new("spec/data/not_found.txt")
      Brickftp::Upload.create(path: "abc.txt", source: "abc.txt")
    rescue Exception => e
      @error = e.message
    end
    expect(@error).to eql("No such file or directory @ rb_sysopen - abc.txt")
  end    
end
