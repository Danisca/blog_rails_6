class AddRoleFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    #role field could be: admin, moderator, regular
    #bydefault all users are regular users
    #the highiest level is admin user
    add_column :users, :user_role, :string, default: "regular"
  end
end
