RSpec.describe 'Brickftp::Group' do
  let(:new_user_1) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  let(:new_user_2) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  let(:new_user_3) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end     

  it 'List of groups' do
    group_list = Brickftp::Group.list
    grpup_list_ids_arr = group_list.map{|group| group["id"]}
    expect(group_list.size).to eq(grpup_list_ids_arr.size)
  end  
 
  describe 'Create Group' do
    context 'Valid' do
      before do
        @user_1 = new_user_1
        @user_2 = new_user_2
      end
      it 'Create new group' do
        new_group = Brickftp::Group.create({name: "test_group#{SecureRandom.hex(2)}", user_ids: "#{@user_1['id']},#{@user_2['id']}"})
        group = Brickftp::Group.show(new_group['id'])
        expect(new_group['id']).to eql(group['id'])
      end
    end

    context 'Invalid' do
      it 'Group not created, Group Name can not be blank!' do
        new_group = Brickftp::Group.create({})
        expect(new_group["errors"][0]).to eql("Group Name can't be blank")
      end
    end
  end

  describe 'Group#show, Group#not_exists, Group#create_user, Group#memberships, and Group#update' do
    before do
      @user_1 = new_user_1
      @user_2 = new_user_2
      @new_group = Brickftp::Group.create({name: "test_group#{SecureRandom.hex(2)}", user_ids: "#{@user_1['id']},#{@user_2['id']}"})
    end

    it 'Group exists' do
      group = Brickftp::Group.show(@new_group['id'])
      expect(@new_group['id']).to eql(group['id'])
    end

    it 'Group does not exists, Id is invalid!' do
      begin
        Brickftp::Group.show('test')
      rescue Exception => e
        @error = e.message
      end
      expect(@error).to eql('id is invalid')
    end

    it 'Update existing Group' do
      name = "test_group#{SecureRandom.hex(2)}"
      group = Brickftp::Group.update(@new_group['id'],{name: name})
      expect(group['name']).to eq(name)
    end

    it 'Create a user to existing Group' do
      username = "testuser#{SecureRandom.hex(2)}"
      new_user = Brickftp::Group.create_user(@new_group['id'], {user: {username: username, email: "#{username}@email.com"}})
      expect(new_user["username"]).to eq(username)
    end

    it 'Add a user to existing Group' do
      new_user = new_user_3
      membership = Brickftp::Group.memberships(@new_group['id'], new_user['id'], {membership: {admin: true}})
      expect(membership["user_id"]).to eq(new_user["id"])
    end

    it 'Update a user to existing Group' do
      new_user = new_user_3
      membership = Brickftp::Group.memberships(@new_group['id'], new_user['id'], {membership: {admin: true}})
      updated_membership = Brickftp::Group.update_memberships(@new_group['id'], new_user['id'], {membership: {admin: false}})
      expect(updated_membership["admin"]).to eq(false)
    end

    it 'Remove a member to existing Group' do
      group = @new_group
      prev_user_lists_array = group["user_ids"].split(",")
      Brickftp::Group.delete_memberships(group["id"], prev_user_lists_array[0])
      updated_group = Brickftp::Group.show(group["id"])
      expect(updated_group['user_ids'].split(',').size).to eq(prev_user_lists_array.size - 1)
    end                  
  end

  describe 'Group#delete' do
    before do
      @user_1 = new_user_1
      @user_2 = new_user_2
      @new_group = Brickftp::Group.create({name: "test_group#{SecureRandom.hex(2)}", user_ids: "#{@user_1['id']},#{@user_2['id']}"})
    end

    it 'Delete existing Group' do
      prev_list = Brickftp::Group.list
      Brickftp::Group.delete(@new_group['id'])
      new_list = Brickftp::Group.list
      expect(new_list.size).to eq(prev_list.size - 1)
    end
  end    
end
