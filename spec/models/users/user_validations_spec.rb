require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_most(50) }

    it { should validate_presence_of(:street) }
    it { should validate_length_of(:street).is_at_most(100) }
    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_at_most(100) }
    it { should validate_presence_of(:state) }
    it { should validate_length_of(:state).is_at_most(50) }

    it { should validate_presence_of(:zip) }
    it { should validate_length_of(:zip).is_at_most(10) }
    it { should allow_value('12345').for(:zip) }
    it { should allow_value('12345-6789').for(:zip) }
    it { should_not allow_value('123456').for(:zip) }
    it { should_not allow_value('1234').for(:zip) }
    it { should_not allow_value('abcd-efgh').for(:zip) }

    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:phone).is_at_most(15) }
    it { should allow_value('+1234567890').for(:phone) }
    it { should allow_value('123-456-7890').for(:phone) }
    it { should_not allow_value('1234567890123456').for(:phone) }
    it { should_not allow_value('12').for(:phone) }
    it { should_not allow_value('invalid').for(:phone) }

    it { should validate_presence_of(:time_zone) }
    it { should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }

    it { should validate_length_of(:email).is_at_most(255) }

    context 'password complexity' do
      it 'requires at least one special character' do
        user = User.new(password: 'Password123')
        user.valid?
        expect(user.errors[:password]).to include('must include at least one special character (e.g. !@#$%^&*)')
      end

      it 'accepts passwords with special characters' do
        user = User.new(password: 'Password!123')
        user.valid?
        expect(user.errors[:password]).to be_empty
      end
    end

    context 'SQL injection patterns' do
      it 'sanitizes fields with SQL injection patterns' do
        # Attempt SQL injection via the first name field
        user = User.new(first_name: "John; DROP TABLE users; --", last_name: "Doe", email: "test@example.com",
                        phone: "123-456-7890", password: "password123@", password_confirmation: "password123@",
                        street: "123 Elm St", city: "Anytown", state: "California", zip: "12345", 
                        time_zone: "Pacific Time (US & Canada)")
        
        expect(user.valid?).to be_truthy # Model should still be valid after sanitization
        require 'pry'; binding.pry
        expect(user.first_name).not_to include("DROP TABLE") # The harmful SQL is sanitized out
      end

      it 'accepts names with single quotes' do
        user = User.new(first_name: "O'Brien", last_name: 'Doe')
        user.valid?
        expect(user.errors[:base]).to be_empty
      end

      it 'allows double quotes in names' do
        user = User.new(first_name: 'John "Johnny" Doe')
        user.valid?
        expect(user.errors[:base]).to be_empty
      end

      it 'accepts normal input without SQL injection patterns' do
        user = User.new(first_name: 'John')
        user.valid?
        expect(user.errors[:base]).to be_empty
      end
    end

    context 'dealing with time zones' do
      it 'is invalid with an unsupported time zone' do
        user2 = build(:user, time_zone: 'Invalid Time Zone')
        expect(user2).not_to be_valid
        expect(user2.errors[:time_zone]).to include('is not included in the list')
      end

      it 'is invalid when time zone is blank' do
        user = build(:user, time_zone: nil)
        expect(user).not_to be_valid
        expect(user.errors[:time_zone]).to include("can't be blank")
      end
    end
  end
end
