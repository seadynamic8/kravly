namespace :image do
  desc "Recreate Images in the ImageUploader of Carrierwave"
  task recreate: :environment do
  	ideas = Idea.all
			ideas.each do |idea|
				idea.image.recreate_versions! if idea.image.present?
				idea.save!
			end
  end

end
