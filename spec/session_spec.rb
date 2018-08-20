RSpec.describe 'Brickftp::Session' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  describe 'Session#login' do
    context 'Valid' do
      before do
        @user = new_user
      end

      it 'Session#login' do
        login_result = Brickftp::Session.login({username: @user['username'], password: "password@123"})
        is_login = login_result.has_key?("id")
        expect(is_login).to eql(true)
      end
    end

    context 'Invalid' do
      it 'Can not log in as invalid username or password' do
        begin
          Brickftp::Session.login({username: "testuser#{SecureRandom.hex(2)}", password: "testuser#{SecureRandom.hex(2)}"})
        rescue Exception => e
          @error = e.message
        end
        expect(@error).to eql('invalid username or password')
      end
    end
  end   
end
