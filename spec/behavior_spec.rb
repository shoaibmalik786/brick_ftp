RSpec.describe 'Brickftp::Behavior' do 

  it 'List of behaviors' do
    behavior_list = Brickftp::Behavior.list
    behavior_list_ids_arr = behavior_list.map{|group| group["id"]}
    expect(behavior_list.size).to eq(behavior_list_ids_arr.size)
  end  
 
  describe 'Create Behavior' do
    context 'Valid' do
      before do
        @folder_path = "folder#{SecureRandom.hex(3)}"
        Brickftp::Folder.create(@folder_path)
      end

      it 'Create new Behavior' do
        new_behavior = Brickftp::Behavior.create({path: @folder_path, behavior: "webhook", value: ["https://d.mywebhookhandler.com"]})
        expect(new_behavior['path']).to eql(@folder_path)
      end
    end

    context 'Invalid' do
      it 'Behavior not created, path is missing, behavior is missing!' do
        begin
          Brickftp::Behavior.create()
        rescue Exception => e
          error = e.message
        end
        expect(error).to eql("path is missing, behavior is missing")
      end
    end
  end

  describe 'Behavior#show, Behavior#update, Behavior#delete' do
    before do
      @folder_path = "folder#{SecureRandom.hex(3)}"
      Brickftp::Folder.create(@folder_path)
      @new_behavior = Brickftp::Behavior.create({path: @folder_path, behavior: "webhook", value: ["https://d.mywebhookhandler.com"]})
    end

    it 'Behavior exists' do
      behavior = Brickftp::Behavior.show(@new_behavior['id'])
      expect(behavior['id']).to eql(@new_behavior['id'])
    end

    it 'Behavior does not exists, Id is invalid!' do
      begin
        Brickftp::Behavior.show('test')
      rescue Exception => e
        @error = e.message
      end
      expect(@error).to eql('id is invalid')
    end

    it 'Update existing Behavior' do
      value = "https://e.mywebhookhandler.com"
      behavior = Brickftp::Behavior.update(@new_behavior['id'],{value: [value]})
      expect(behavior['value'][0]).to eq(value)
    end                
  end

  describe 'Behavior#delete' do
    before do
      @folder_path = "folder#{SecureRandom.hex(3)}"
      Brickftp::Folder.create(@folder_path)
      @new_behavior = Brickftp::Behavior.create({path: @folder_path, behavior: "webhook", value: ["https://d.mywebhookhandler.com"]})
    end

    it 'Delete existing Behavior' do
      prev_list = Brickftp::Behavior.list
      Brickftp::Behavior.delete(@new_behavior['id'])
      new_list = Brickftp::Behavior.list
      expect(new_list.size).to eq(prev_list.size - 1)
    end
  end

  describe 'Behavior#list_folder' do
    before do
      @folder_path = "folder#{SecureRandom.hex(3)}"
      Brickftp::Folder.create(@folder_path)
      @new_behavior = Brickftp::Behavior.create({path: @folder_path, behavior: "webhook", value: ["https://d.mywebhookhandler.com"]})
    end

    it 'list folder behavior' do
      folder_behavior = Brickftp::Behavior.list_folder(@folder_path)
      expect(folder_behavior[0]["path"]).to eql(@folder_path)
    end
  end      
end
