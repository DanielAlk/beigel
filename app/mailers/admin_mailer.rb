class AdminMailer < ApplicationMailer
	default to: ENV['NOTIFICATIONS_MAILER_TO']

	def notification(contact)
		@contact = contact

		case contact.subject.to_sym
		when :contact
			@subject = 'Contacto en la Web'
		when :services
			@subject = 'Contacto por servicios'
		when :investments
			@subject = 'Contacto por inversiones'
		when :assessments
			@subject = 'Contacto por tasaciones'
		when :development
			@subject = %(Contacto en "#{@contact.contactable.title}")
		when :property
			@subject = %(Contacto en "#{@contact.contactable.title}")
		end

		mail subject: @subject
	end
end
