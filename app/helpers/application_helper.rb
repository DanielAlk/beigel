module ApplicationHelper
	def head_allow_robots?
		true
	end

	def head_title
		case params['action']
		when 'home'
			'Beigel'
		else
			'Beigel'
		end
	end

	def head_description
		''
	end

	def head_og_image
		''
	end

	def nav_class(action = nil)
		if action.kind_of? Array
			'active' if action.include? params['action']
		else
			'active' if action == params['action']
		end
	end
end
