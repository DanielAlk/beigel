module NavigationHelper
	def navigation_ul_class(format)
		case format
		when :header
			'list-inline'
		when :footer
			'list-unstyled footer-navigation'
		when :menu
			'list-unstyled'
		end
	end

	def nav_class(action = nil, instances = nil)
		if action.kind_of? Array
			'active' if action.include? params['action'].to_sym
		elsif instances.blank?
			'active' if action.to_s == params['action']
		elsif action.to_s == params['action']
			instances.each do |key, value|
				if instance_variable_get('@'+key.to_s) == value
					return 'active'
				end
			end
		end
	end
end