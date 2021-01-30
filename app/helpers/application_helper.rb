module ApplicationHelper
	def gravatar_for(user, options = {size: 80})
		size = options[:size]
		email_address = user.email
		hsh = Digest::MD5.hexdigest(email_address)
		image_url = "https://www.gravatar.com/avatar/#{hsh}?s=#{size}"
		image_tag(image_url, alt: user.username,class: "mx-auto d-block rounded shadow mb-2")
	end
end
