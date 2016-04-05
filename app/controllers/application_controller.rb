class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def build_params_string(params_list, params_format)
  	string = ''
  	params_format.each do |key, param|
  		if param.respond_to? :each
  			group_string = ''
  			param_is_present = true
  			param.each do |k, p|
  				if param_is_present && param_is_present = params_list[k].present?
	  				if p.respond_to? :each and p[:digit].present?
	  					group_string << '/' + params_list[k].gsub(/[^\d]/,'') + '-' + p[:id].to_s
	  				else
	  					group_string << '/' + params_list[k] + '-' + p.to_s
	  				end
  				end
  			end
				string << group_string if param_is_present
			elsif params_list[key].present?
  			string << '/' + params_list[key].join('-' + param.to_s + '/')
  			string << '-' + param.to_s
  		end
  	end
  	return string.sub('/','')
  end

  def parse_params_string(params_list, params_format)
  	obj = {}
  	params_format.each do |key, param|
  		if param.respond_to? :each
  			group_obj = {}
  			param_is_present = true
  			param.each do |k, p|
  				if param_is_present
  					if p.respond_to? :each and p[:digit].present? && value = params_list[Regexp.new '(\/\d+-' + p[:id].to_s + ')+']
	  					params_list = params_list.sub(value, '')
	  					length = p[:id].to_s.length+2
	  					obj[k] = value.sub('/','').split('/').map { |n| n[0..-length].to_i }
	  				elsif	value = params_list[Regexp.new '(\/\w+-' + p.to_s + ')']
	  					params_list = params_list.sub(value, '')
	  					length = p.to_s.length+2
	  					obj[k] = value.sub('/','')[0..-length]
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
			elsif value = params_list[Regexp.new '(\/\w+-' + param.to_s + ')+']
  			params_list = params_list.sub(value, '')
  			length = param.to_s.length+2
  			obj[key] = value.sub('/','').split('/').map { |n| n[0..-length] }
  		end
  	end
  	return obj
  end

end