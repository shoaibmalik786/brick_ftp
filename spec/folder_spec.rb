require "rack/test"
RSpec.describe 'Brickftp::Folder' do
  describe 'List Folder' do
    before do
      @folder_path = "folder#{SecureRandom.hex(3)}"
      Brickftp::Folder.create(@folder_path)
    end

    it 'List#folder' do
      folder_list = Brickftp::Folder.list(@folder_path)
      expect(folder_list.size).to eq(0)
    end
  end  

  describe 'Create Folder' do
    context 'Valid' do
      before do
        @folder_path = "folder#{SecureRandom.hex(3)}"
        Brickftp::Folder.create(@folder_path)
      end

      it 'Create new Folder' do
        folder_list = Brickftp::Folder.list(@folder_path)
        expect(folder_list.size).to eq(0)
      end
    end
  end

  describe 'Folder#count_contents, Folder#count_nrs_contents, Folder#size and Folder#move_or_rename' do
    before do
      @folder_path = "folder#{SecureRandom.hex(3)}"
      Brickftp::Folder.create(@folder_path)
    end

    it 'Folder#count_contents' do
      folder = Brickftp::Folder.count_contents(@folder_path)
      expect(folder["data"]["count"]).to eq(0)
    end

    it 'Folder#count_nrs_contents' do
      folder = Brickftp::Folder.count_nrs_contents(@folder_path)
      expect(folder["data"]["count"]["files"]).to eq(0)
    end

    it 'Folder#size' do
      folder = Brickftp::Folder.size(@folder_path)
      expect(folder["data"]["size"]).to eq(0)
    end

    it 'Folder#move_or_rename' do
      destination_folder = "folder#{SecureRandom.hex(3)}"
      folder = Brickftp::Folder.move_or_rename(@folder_path, {"move-destination": destination_folder})
      expect(folder.size).to eq(0)
    end

    it 'Folder#copy' do
      destination_path = "folder#{SecureRandom.hex(3)}"
      folder = Brickftp::Folder.copy(@folder_path, {"copy-destination": destination_path})
      expect(folder.size).to eq(0)
    end

    it 'Folder#delete' do
      folder = Brickftp::Folder.delete(@folder_path)
      expect(folder.size).to eq(0)
    end                                     
  end

  describe 'Folder#depth_delete' do
    context 'Valid' do
      before do
        @folder_path = "folder#{SecureRandom.hex(3)}"
        Brickftp::Folder.create(@folder_path)
      end

      it 'Delete depth_delete' do
        delete_folder = Brickftp::Folder.depth_delete(@folder_path)
        expect(delete_folder.size).to eq(0)
      end
    end

    context 'Invalid' do
      it 'can not delete as file not found.' do
        begin
          Brickftp::Folder.depth_delete("folder#{SecureRandom.hex(3)}")
        rescue Exception => e
          @error = e.message
        end
        expect(@error).to eql('Not Found')
      end
    end
  end

  describe 'Folder#download_file' do
    context 'Valid' do
      before do
        file = Rack::Test::UploadedFile.new("spec/data/test_download.txt")
        res = Brickftp::Upload.create(path: "#{file.original_filename}", source: file)
        @path = res['path']
      end

      it 'download file' do
        download_response = Brickftp::Folder.download_file(@path)
        expect(download_response["path"]).to eql(@path)
      end
    end
  end      
end
