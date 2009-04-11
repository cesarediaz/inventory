class AddAdminUser < ActiveRecord::Migration
  def self.up
    admin = User.find_by_login("admin")
    admin.destroy if admin

    user = User.create(:login => 'admin', :email => "admin@inventory.com",
                :password => "testing", :password_confirmation => "testing",
                :name => "admin")

    user.save!
  end

  def self.down
    User.find_by_login("admin").destroy
  end
end
