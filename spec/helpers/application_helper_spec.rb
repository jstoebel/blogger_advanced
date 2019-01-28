require 'rails_helper'

describe '#current_user_is_admin?' do
  [true, false].each do |is_admin|
    it "returns #{is_admin} for url param `admin=#{is_admin}`" do
      allow(helper).to receive(:params).and_return(admin: is_admin.to_s)
      expect(helper.current_user_is_admin?).to eq is_admin
    end
  end
end
