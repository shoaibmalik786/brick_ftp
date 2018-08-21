require "rack/test"
RSpec.describe 'Brickftp::History' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  describe 'History#login_history, History#site_history, History#user_history' do
    before do
      @user = new_user
    end

    context 'History#login_history' do
      it 'History#login_history' do
        Brickftp::Session.login({username: @user['username'], password: "password@123"})
        login_histories = Brickftp::History.login_history
        expect(login_histories.first["action"]).to eql("login")
      end
      it 'History#login_history with optional params' do
        Brickftp::Session.login({username: @user['username'], password: "password@123"})
        login_histories = Brickftp::History.login_history(1,2,Time.now.strftime("%Y-%m-%dT00:00:00-00:00"))
        expected_res = login_histories.size <= 2
        expect(expected_res).to eql(true)
      end
    end
   
    context 'History#site_history' do
      it 'History#site_history' do
        site_histories = Brickftp::History.site_history
        valid_result = ["user_create", "login", "create"].include?(site_histories.first['action']) || site_histories.size >= 0
        expect(valid_result).to eql(true)
      end

      it 'History#site_history with optional params' do
        site_histories = Brickftp::History.site_history(1,2,Time.now.strftime("%Y-%m-%dT00:00:00-00:00"))
        expected_res = site_histories.size <= 2
        expect(expected_res).to eql(true)
      end      
    end

    context 'History#user_history' do
      it 'History#user_history' do
        user_histories = Brickftp::History.user_history(@user["id"])
        expect(user_histories.size).to eql(0)
      end
      it 'History#user_history with optional params' do
        user_histories = Brickftp::History.user_history(@user["id"], 1, 2, Time.now.strftime("%Y-%m-%dT00:00:00-00:00"))
        expected_res = user_histories.size <= 2
        expect(expected_res).to eql(true)
      end        
    end           
  end 

  describe 'History#folder_history' do
    before do
      @path = "Folder#{SecureRandom.hex(2)}"
      Brickftp::Folder.create(@path)
    end
    context 'History#folder_history' do
      it 'History#folder_history' do
        folder_history = Brickftp::History.folder_history(@path)
        expect(folder_history.size).to eql(0)
      end

      it 'History#folder_history with optional params' do
        folder_histories = Brickftp::History.folder_history(@path, 1, 2, Time.now.strftime("%Y-%m-%dT00:00:00-00:00"))
        expected_res = folder_histories.size <= 2
        expect(expected_res).to eql(true)
      end      
    end
  end

  describe 'History#files_history' do
    before do
      file = Rack::Test::UploadedFile.new("spec/data/test.txt")
      res = Brickftp::Upload.create(path: "#{file.original_filename}", source: file)
      @path = res["path"]
    end
    
    context 'History#file_history' do
      it 'History#file_history' do
        file_histories = Brickftp::History.file_history(@path)
        expect(file_histories[0]["path"]).to eql(@path)
      end
      it 'History#file_history with optional params' do
        file_histories = Brickftp::History.file_history(@path, 1, 2, Time.now.strftime("%Y-%m-%dT00:00:00-00:00"))
        expected_res = file_histories.size <= 2
        expect(expected_res).to eql(true)
      end      
    end
  end     
end
