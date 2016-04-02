module PagesHelper
	def currency(number, unit)
		number_to_currency(number, delimiter: '.', separator: ',', precision: 0, unit: unit) || '-'
	end
end
