class Permission

	def initialize(user)
		permit :public, [:index, :about]
		permit :sessions, [:new, :create, :destroy]
		permit :password_resets, [:new, :create, :edit, :update]
		permit :users, [:new, :create, :boards, :ideas, :votes]
		permit :boards, [:show]
		permit :ideas, [:index, :show]
		if user
			permit :users, [:edit, :update, :destroy, :settings] do |u|
				u == user
			end
			permit :boards, [:new, :create]
			permit :boards, [:edit, :update, :destroy] do |board|
				board.user == user
			end
			permit :ideas, [:new, :create]
			permit :ideas, [:edit, :update, :destroy] do |idea|
				idea.user == user
			end
			permit :ideas, [:vote] do |idea|
				idea.user != user
			end
			permit :comments, [:create]
			permit :comments, [:edit, :update] do |comment|
				comment.user == user
			end
			permit_all if user.admin?
		end
	end

	def permit_all(controller = nil)
		@permit_all = true
	end

	def permit(controllers, actions, &block)
		@permited_actions ||= {}
		Array(controllers).each do |controller|
			Array(actions).each do |action|
				@permited_actions[[controller.to_s, action.to_s]] = block || true
			end
		end
	end

	def permit?(controller, action = nil, resource = nil)
		permitted = @permit_all || @permited_actions[[controller.to_s, action.to_s]]
		permitted && (permitted == true || resource && permitted.call(resource))
	end
end