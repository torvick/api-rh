class Registration < ApplicationRecord
  belongs_to :user
  # before_create :validate_day?

  with_options if: Proc.new { |t| t.user.present? } do |with_users|
    with_users.validate :validate_day?
  end

  def validate_day?
    # self.check_in = Time.now
    puts Registration.where(user: self.user).where(check_in: self.check_in).inspect
    errors.add(:check_in, "can't be same as the receiving user.") if !Registration.where(user: self.user).where(check_in: self.check_in).empty?
    raise "#{!Registration.where(user: self.user).where(check_in: self.check_in).empty?}-#{Registration.where(user: self.user).where(check_in: self.check_in).empty?}"
  end
end
