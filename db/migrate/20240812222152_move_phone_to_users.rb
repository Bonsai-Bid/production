class MovePhoneToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :phone, :string
    
    # Migrate phone numbers from user_profiles to users
    UserProfile.find_each do |profile|
      profile.user.update(phone: profile.phone)
    end

    remove_column :user_profiles, :phone
  end

  def down
    add_column :user_profiles, :phone, :string
    
    # Rollback phone numbers from users to user_profiles
    User.find_each do |user|
      user.user_profile.update(phone: user.phone)
    end

    remove_column :users, :phone
  end
end
