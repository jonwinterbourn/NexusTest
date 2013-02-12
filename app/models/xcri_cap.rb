class XcriCap
	#attr_reader :description, :identifier
	attr_reader :state, :city, :area_code, :time_zone

	def initialize(id)

		client = Savon::Client.new(wsdl: "http://www.webservicex.net/uszip.asmx?WSDL")
    #response = client.request :web, :get_info_by_zip, body: { "USZip" => id }
    response = client.call(:get_info_by_zip, message: { "USZip" => id })
#		if response.success?
    	#data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first
			data = response.to_hash[:get_info_by_zip_response][:get_info_by_zip_result][:new_data_set][:table]	    
		#if data
				@state = data[:state]
				@city = data[:city]
				@area_code = data[:area_code]
				@time_zone = data[:time_zone]
#	    end
#    end

	end
end



