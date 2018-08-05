RSpec.describe 'Brickftp::Upload' do
  it 'Upload#start' do
    file_name = "test_file#{SecureRandom.hex(2)}.ext"
    start_upload = Brickftp::Upload.start(file_name, {action: "put"})
    expect(file_name).to eql(start_upload["path"])
  end

  describe 'Upload#request_additional' do
    before do
      @file_name = "test_file#{SecureRandom.hex(2)}.ext"
      @start_upload = Brickftp::Upload.start(@file_name, {action: "put"})
    end

    it 'Upload#request_additional' do
      request_additional = Brickftp::Upload.request_additional(@file_name, {action: "put", ref: @start_upload['ref'], part: 2})
      expect(request_additional['part_number']).to eql(2)
    end
  end 

  describe 'Upload#complete' do
    # context 'Valid' do
    #   before do
    #     @file_name = "test_file#{SecureRandom.hex(2)}.ext"
    #     @start_upload = Brickftp::Upload.start(@file_name, {action: "put"})
    #   end
      
    #   it 'Upload#complete' do
    #     complete_upload = Brickftp::Upload.complete(@file_name, {action: "end", ref: @start_upload['ref']})
    #     expect(complete_upload['path']).to eql(@file_name)
    #   end
    # end

    context 'Invalid' do
      before do
        @file_name = "test_file#{SecureRandom.hex(2)}.ext"
        @start_upload = Brickftp::Upload.start(@file_name, {action: "put"})
      end
      
      it 'Upload#complete' do
        begin
          complete_upload = Brickftp::Upload.complete(@file_name, {action: "end", ref: @start_upload['ref']})
        rescue Exception => e
          error = e.message
        end
        expect(error).to eql("file not uploaded")
      end
    end       
  end   
end
