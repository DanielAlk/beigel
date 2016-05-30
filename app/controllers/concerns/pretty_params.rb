module PrettyParams
	extend ActiveSupport::Concern

	def prettify_params(params_list)
		string = ''
		self.pretty_params_format.each do |key, param|
			if param.respond_to? :each and param[:id].present? and params_list[key].present?
				string << '/' + params_list[key].map { |p| param[:map][p.to_sym] || p.to_sym }.join('-' + param[:id].to_s + '/')
				string << '-' + param[:id].to_s
			elsif param.respond_to? :each
				group_string = ''
  			param_is_present = true
  			param.each do |k, p|
  				if param_is_present && param_is_present = params_list[k].present?
  					group_string << '/' + params_list[k] + '-' + p.to_s
  				end
  			end
  			string << group_string if param_is_present
  		elsif params_list[key].present?
  			string << '/' + params_list[key].join('-' + param.to_s + '/')
  			string << '-' + param.to_s
  		end
  	end
  	return string.sub('/','').gsub(/[^\d\w\/-]/, '')
  end

  def parse_pretty_params(params_list)
  	obj = {}
  	self.pretty_params_format.each do |key, param|
  		if param.respond_to? :each and param[:id].present? && value = params_list[Regexp.new '(\/[\w\d-]+-' + param[:id].to_s + ')+']
  			params_list = params_list.sub(value, '')
  			length = param[:id].to_s.length+2
  			obj[key] = value.sub('/','').split('/').map do |n|
  				n = n[0..-length]
  				param[:map].key(n.to_sym) || n
  			end
  		elsif param.respond_to? :each
  			group_obj = {}
  			param_is_present = true
  			param.each do |k, p|
  				if param_is_present
  					if value = params_list[Regexp.new '(\/[\w\d-]+-' + p.to_s + ')']
	  					params_list = params_list.sub(value, '')
	  					length = p.to_s.length+2
	  					obj[k] = value.sub('/','').split('/').map { |n| n[0..-length] }[0]
	  				else
	  					param_is_present = false
	  				end
	  			end
	  		end
	  		if param_is_present
	  			group_obj.each do |o|
	  				obj << o
	  			end
	  		end
	  	elsif value = params_list[Regexp.new '(\/[\w\d-]+-' + param.to_s + ')+']
	  		params_list = params_list.sub(value, '')
  			length = param.to_s.length+2
  			obj[key] = value.sub('/','').split('/').map { |n| n[0..-length] }
  		end
  	end
  	return obj
  end
end