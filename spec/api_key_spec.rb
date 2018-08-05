RSpec.describe 'Brickftp::ApiKey' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  describe 'Create ApiKey' do
    context 'Valid' do
      before do
        @new_user = new_user
      end

      it 'Create new ApiKey' do
        new_api_key = Brickftp::ApiKey.create(@new_user['id'], {name: "key#{SecureRandom.hex(1)}", permission_set: "full"})
        api_key = Brickftp::ApiKey.show(new_api_key['id'])
        expect(new_api_key['id']).to eql(api_key['id'])
      end
    end

    context 'Invalid' do
      it 'ApiKey not created, id is invalid, name is missing' do
        begin
          Brickftp::ApiKey.create('test', {})
        rescue Exception => e
          @error = e.message
        end  
        expect(@error).to eql('id is invalid, name is missing')
      end
    end
  end

  describe 'ApiKey#show ApiKey#list and ApiKey#delete' do
    before do
      @new_user = new_user
      @new_api_key = Brickftp::ApiKey.create(@new_user['id'], {name: "key#{SecureRandom.hex(1)}", permission_set: "full"})
    end

    it 'ApiKey exists' do
      api_key = Brickftp::ApiKey.show(@new_api_key['id'])
      expect(@new_api_key['id']).to eql(api_key['id'])
    end

    it 'List ApiKey' do
      list = Brickftp::ApiKey.list(@new_user['id'])
      expect(list.size).to be > 0
    end

    it 'Delete a ApiKey' do
      list_keys = Brickftp::ApiKey.list(@new_user['id'])
      api_key = Brickftp::ApiKey.delete(@new_api_key['id'])
      after_delete_keys = Brickftp::ApiKey.list(@new_user['id'])
      expect(after_delete_keys.size).to eql(list_keys.size - 1)
    end        
  end     
end
