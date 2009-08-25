xml.instruct!
xml.feature do
	@feature.each do |k,v|
		xml.tag!(k, v)
	end
end

