require "spec_helper"

describe UserMailer do
	describe "password_reset" do
		let(:user) { create(:user, password_reset_token: "anything") }
		let(:mail) { UserMailer.password_reset(user) }

		it "sends user password reset url" do
			expect(mail.subject).to eq("kravly - Password Reset")
			expect(mail.to).to eq([user.email])
			expect(mail.from).to eq(["kravlysite@gmail.com"])
		end

		it "renders the body" do
			expect(mail.body.encoded).to match(edit_password_reset_path(user.password_reset_token))
		end
	end
end
