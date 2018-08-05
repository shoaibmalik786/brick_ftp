RSpec.describe 'Brickftp::Permission' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  let(:new_permission) do
    @new_user = new_user
    Brickftp::Permission.create({path: "/test#{SecureRandom.hex(2)}", permission: "writeonly", user_id: @new_user['id']})
  end

  it 'Permission#list' do
    new_permission = new_permission
    list = Brickftp::Permission.list
    expect(list.size).to be > 0
  end    

  describe 'Permission#create' do
    context 'Valid' do
      before do
        @prev_count = Brickftp::Permission.list.size
        @new_permission = new_permission
      end

      it 'Create new Permission' do
        new_count = Brickftp::Permission.list.size
        expect(new_count).to eql(@prev_count + 1)
      end
    end

    context 'Invalid' do
      it 'Permission not created, Path is invalid, Permission must have one of user or group set' do
        permission = Brickftp::Permission.create()
        expect(permission["errors"].join(',')).to eql('Path is invalid,Permission must have one of user or group set')
      end

      it 'Permission not created, Permission must have one of user or group set' do
        permission = Brickftp::Permission.create({path: "/test#{SecureRandom.hex(2)}"})
        expect(permission["errors"].join(',')).to eql('Permission must have one of user or group set')
      end      
    end
  end

  describe 'Permission#delete' do
    before do
      @new_permission = new_permission
    end
    it 'Delete a Permission' do
      prev_count = Brickftp::Permission.list.size
      Brickftp::Permission.delete(@new_permission['id'])
      new_count = Brickftp::Permission.list.size
      expect(new_count).to eq(prev_count - 1)
    end
  end       
end
