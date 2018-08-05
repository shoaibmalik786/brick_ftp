RSpec.describe 'Brickftp::History' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  describe 'History#login_history, History#site_history, History#user_history' do
    before do
      @user = new_user
    end

    it 'History#login_history' do
      Brickftp::Session.login({username: @user['username'], password: "password@123"})
      login_histories = Brickftp::History.login_history
      expect(login_histories.first["action"]).to eql("login")
    end

    it 'History#site_history' do
      site_histories = Brickftp::History.site_history
      valid_result = ["user_create", "login", "create"].include?(site_histories.first['action'])
      expect(valid_result).to eql(true)
    end

    it 'History#user_history' do
      user_histories = Brickftp::History.user_history(@user["id"])
      expect(user_histories.size).to eql(0)
    end            
  end 

  describe 'History#folder_history' do
    before do
      @path = "Folder#{SecureRandom.hex(2)}"
      Brickftp::Folder.create(@path)
    end

    it 'History#folder_history' do
      folder_history = Brickftp::History.folder_history(@path)
      expect(folder_history.size).to eql(0)
    end
  end

  # describe 'History#files_history' do
  #   before do
  #     @path = "Files#{SecureRandom.hex(2)}"
  #     Brickftp::Folder.create(@path)
  #   end

  #   it 'History#folder_history' do
  #     file_history = Brickftp::History.file_history(@path)
  #     expect(file_history.size).to eql(0)
  #   end
  # end     
end
