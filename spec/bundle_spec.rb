RSpec.describe 'Brickftp::Bundle' do
  let(:new_bundle) do
    folder_path = "folder#{SecureRandom.hex(3)}"
    Brickftp::Folder.create(folder_path)
    Brickftp::Bundle.create({paths: [folder_path], password: "password"})
  end       

  it 'List of bundles' do
    bundle_list = Brickftp::Bundle.list
    bundle_list_ids_arr = bundle_list.map{|bundle| bundle["id"]}
    expect(bundle_list.size).to eq(bundle_list_ids_arr.size)
  end  
 
  describe 'Create Bundle' do
    context 'Valid' do
      before do
        @folder_path = "folder#{SecureRandom.hex(3)}"
        Brickftp::Folder.create(@folder_path)
        @new_bundle = Brickftp::Bundle.create({paths: [@folder_path], password: "password"})        
      end

      it 'Create new Bundle' do
        expect(@new_bundle["paths"][0]).to eql(@folder_path)
      end
    end

    context 'Invalid' do
      it 'Bundle not created, paths is missing' do
        begin
          new_bundle = Brickftp::Bundle.create()
        rescue Exception => e
          error = e.message
        end
        expect(error).to eql("paths is missing")
      end

      it 'Bundle not created, Filename does not match' do
        random_path = "folder#{SecureRandom.hex(2)}"
        new_bundle = Brickftp::Bundle.create({paths: [random_path]})
        expect(new_bundle["errors"].join).to eql("Filename does not match existing file at: #{random_path}")
      end      
    end
  end

  describe 'Bundle#show, Bundle#contents, Bundle#download, Bundle#download_zip and Bundle#delete' do
    before do
      @new_bundle = new_bundle
    end

    it 'Bundle exists' do
      bundle = Brickftp::Bundle.show(@new_bundle['id'])
      expect(@new_bundle['id']).to eql(bundle['id'])
    end

    it 'Bundle does not exists, id is invalid!' do
      begin
        Brickftp::Bundle.show('test')
      rescue Exception => e
        @error = e.message
      end
      expect(@error).to eql('id is invalid')
    end

    it 'Bundle#contents' do
      contents = Brickftp::Bundle.contents(nil, {code: @new_bundle["code"], password: "password"})
      expect(contents.first["type"]).to eq("directory")
    end

    it 'Bundle#download' do
      begin
        Brickftp::Bundle.download({code: new_bundle["code"], password: "password", path: new_bundle["paths"][0]})
      rescue Exception => e
        error = e.message
      end
      expect(error).to eq("cannot download directory")
    end 

    it 'Bundle#download_zip' do
      bundle_zip = Brickftp::Bundle.download_zip({code: new_bundle["code"], password: "password"})
      has_download_url = bundle_zip.key?("download_uri")
      expect(has_download_url).to eq(true)
    end 

    it 'Bundle#delete' do
      prev_count = Brickftp::Bundle.list.size
      Brickftp::Bundle.delete(@new_bundle['id'])
      new_count = Brickftp::Bundle.list.size
      expect(new_count).to eq(prev_count - 1)
    end                          
  end    
end
