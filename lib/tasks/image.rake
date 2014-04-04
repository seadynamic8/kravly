namespace :image do
  desc "Recreate Images in the ImageUploader of Carrierwave"
  task recreate_images: :environment do
  	ideas = Idea.all
		ideas.each do |idea|
			idea.image.recreate_versions! if idea.image.present?
			idea.save!
		end
  end

  desc "Recreate Avatars in the AvatarUploader of Carrierwave"
  task recreate_avatars: :environment do
  	users = User.all
  	users.each do |user|
  		user.avatar.recreate_versions! if user.avatar.present?
  		user.save!
  	end
  end
end
