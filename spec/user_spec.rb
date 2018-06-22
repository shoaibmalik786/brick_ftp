RSpec.describe 'BrickFtp::User' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    BrickFtp::User.create(username: username, password: 'password@123')
  end

  describe 'Create user' do
    context 'Valid' do
      before do
        @prev_count = BrickFtp::User.count['data']['count']
        new_user
      end
      it 'Create new user' do
        new_count = BrickFtp::User.count['data']['count']
        expect(new_count).to eql(@prev_count + 1)
      end
    end

    context 'Invalid' do
      before do
        @prev_count = BrickFtp::User.count['data']['count']
        BrickFtp::User.create({})
      end

      it 'User not created, username can not blank!' do
        new_count = BrickFtp::User.count['data']['count']
        expect(new_count).not_to eql(@prev_count + 1)
      end
    end
  end

  it 'User count' do
    count = BrickFtp::User.count
    expect(count['data']['count']).not_to be nil
  end

  describe 'User#search User#show and User#unlock' do
    before do
      @new_user = new_user
    end

    it 'Search user' do
      result = BrickFtp::User.search(@new_user['username'], 'username')
      expect(result.size).to be > 0
    end

    it 'User exists' do
      user = BrickFtp::User.show(@new_user['id'])
      expect(user['id']).to eql(user['id'])
    end

    it 'User does not exists, Id is invalid!' do
      begin
        BrickFtp::User.show('test')
      rescue Exception => e
        @error = e.message
      end
      expect(@error).to eql('id is invalid')
    end

    it 'Update existing user' do
      code = SecureRandom.hex(2)
      user = BrickFtp::User.update(@new_user['id'],
                                   username: "testusername#{code}")
      expect(user['username']).to eq("testusername#{code}")
    end

    it 'Unlock locked user' do
      unlock_user = BrickFtp::User.unlock(@new_user['id'])
      expect(unlock_user['last_protocol_cipher']).to be nil
    end
  end

  describe 'User#delete' do
    before do
      @new_user = new_user
    end
    it 'Delete existing user' do
      prev_count = BrickFtp::User.count
      BrickFtp::User.delete(@new_user['id'])
      new_count = BrickFtp::User.count
      expect(new_count['data']['count']).to eq(prev_count['data']['count'] - 1)
    end
  end

  it 'List of users' do
    user_list = BrickFtp::User.list
    expect(user_list.size).to eq(BrickFtp::User.count['data']['count'])
  end
end
