RSpec.describe 'Brickftp::PublicKey' do
  let(:new_user) do
    username = "testuser#{SecureRandom.hex(2)}"
    Brickftp::User.create(username: username, password: 'password@123')
  end

  describe 'Create PublicKey' do
    context 'Valid' do
      before do
        @new_user = new_user
      end

      it 'Create new PublicKey' do
        example_public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnq8wc58VxUmBF75IIPrvol2Hc4+J1mrI6C+6xwlfv62n21ITeumZpMpR6UNIOjyo4bCC8/BZOsiAYn7UXmyYzrlIsX5IuSO1KvG+k+/vRBPexua1s3/kKWRGAloqNBsmoRTun5OgSMp++NaUTDJGRYenzgXKtCWXwGK5iQ0UCAvuhNDx+GhOcSVPzLweBx/h7Sy2EPZhFNf5Ex1fucAaBvxvKLyOqAieLzIIuyCCN5shqxXyH602QYg+JurTqYKB/FaCRA1+1w4uzxAAzaQuUyMS3clmySGiaq9LbvAIw0rItGU31AWyyaCuHmzI3642ShMDDS7tnfZQvWpoykcbF"
        new_public_api_key = Brickftp::PublicKey.create(@new_user['id'], {title: "public_key#{SecureRandom.hex(1)}", public_key: example_public_key})
        public_api_key = Brickftp::PublicKey.show(new_public_api_key['id'])
        expect(new_public_api_key['id']).to eql(public_api_key['id'])
      end
    end

    context 'Invalid' do
      it 'PublicKey not created, id is invalid, title is missing, public_key is missing' do
        begin
          Brickftp::PublicKey.create('test', {})
        rescue Exception => e
          @error = e.message
        end  
        expect(@error).to eql('id is invalid, title is missing, public_key is missing')
      end
    end
  end

  describe 'PublicKey#show PublicKey#list and PublicKey#delete' do
    before do
      @new_user = new_user
      example_public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnq8wc58VxUmBF75IIPrvol2Hc4+J1mrI6C+6xwlfv62n21ITeumZpMpR6UNIOjyo4bCC8/BZOsiAYn7UXmyYzrlIsX5IuSO1KvG+k+/vRBPexua1s3/kKWRGAloqNBsmoRTun5OgSMp++NaUTDJGRYenzgXKtCWXwGK5iQ0UCAvuhNDx+GhOcSVPzLweBx/h7Sy2EPZhFNf5Ex1fucAaBvxvKLyOqAieLzIIuyCCN5shqxXyH602QYg+JurTqYKB/FaCRA1+1w4uzxAAzaQuUyMS3clmySGiaq9LbvAIw0rItGU31AWyyaCuHmzI3642ShMDDS7tnfZQvWpoykcbF"
      @new_public_api_key = Brickftp::PublicKey.create(@new_user['id'], {title: "public_key#{SecureRandom.hex(1)}", public_key: example_public_key})
    end

    it 'PublicKey exists' do
      public_api_key = Brickftp::PublicKey.show(@new_public_api_key['id'])
      expect(@new_public_api_key['id']).to eql(public_api_key['id'])
    end

    it 'List publicKey' do
      list = Brickftp::PublicKey.list(@new_user['id'])
      expect(list.size).to be > 0
    end

    it 'Delete a PublicKey' do
      list_keys = Brickftp::PublicKey.list(@new_user['id'])
      public_api_key = Brickftp::PublicKey.delete(@new_public_api_key['id'])
      after_delete_keys = Brickftp::PublicKey.list(@new_user['id'])
      expect(after_delete_keys.size).to eql(list_keys.size - 1)
    end        
  end     
end
