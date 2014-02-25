module LoginMacros

	def log_in(user)
		visit root_path
		within('nav') { click_link 'Log In' }
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		click_on "Log In"
	end

end