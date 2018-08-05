RSpec.describe 'Brickftp::Notification' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  let(:new_notification) do
    @new_user = new_user
    Brickftp::Notification.create({path: "/test#{SecureRandom.hex(2)}", user_id: @new_user['id']})
  end

  it 'Notification#list' do
    new_notification = new_notification
    list = Brickftp::Notification.list
    expect(list.size).to be > 0
  end    

  describe 'Notification#create' do
    context 'Valid' do
      before do
        @prev_count = Brickftp::Notification.list.size
        @new_notification = new_notification
      end

      it 'Create new Notification' do
        new_count = Brickftp::Notification.list.size
        expect(new_count).to eql(@prev_count + 1)
      end
    end

    context 'Invalid' do
      it "Notification not created, User can't be blank,Path must be non-nil" do
        notification = Brickftp::Notification.create()
        expect(notification["errors"].join(',')).to eql("User can't be blank,Path must be non-nil")
      end

      it "Notification not created, User can't be blank" do
        notification = Brickftp::Notification.create({path: "/test#{SecureRandom.hex(2)}"})
        expect(notification["errors"].join(',')).to eql("User can't be blank")
      end      
    end
  end

  describe 'Notification#delete' do
    before do
      @new_notification = new_notification
    end
    it 'Delete a Notification' do
      prev_count = Brickftp::Notification.list.size
      Brickftp::Notification.delete(@new_notification['id'])
      new_count = Brickftp::Notification.list.size
      expect(new_count).to eq(prev_count - 1)
    end
  end       
end
