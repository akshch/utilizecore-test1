class Parcel < ApplicationRecord

	STATUS = ['Sent', 'In Transit', 'Delivered']
	PAYMENT_MODE = ['COD', 'Prepaid']

	validates :weight, :status, :cost, presence: true
	validates :status, inclusion: STATUS
	validates :payment_mode, inclusion: PAYMENT_MODE
  validates :sender_id, uniqueness: { scope: :receiver_id, message: "Sender ID and Recevier ID cannot be same" }

  belongs_to :service_type
	belongs_to :sender, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	after_commit :send_notification, on: [:create, :update]

	private

	def send_notification
    if self.previous_changes.present? && [:status].any? {|attribute| self.previous_changes.key? attribute}
		  UserMailer.with(parcel: self).status_email.deliver_later
    end
	end

end
