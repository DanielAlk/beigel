module PropertiesHelper

	def property_step step
		(step == :property && params[:step].blank?) || params[:step].present? && Property.statuses.key(Property.steps[params[:step]]) == 'draft_' + step.to_s
	end

end
