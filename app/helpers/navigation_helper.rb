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
end