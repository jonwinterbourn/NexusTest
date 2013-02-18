require 'nokogiri'
class XcriCap
	attr_reader :contributor, :description, :provider_description, :provider_url, :provider_identifier, :provider_title, :course_title, :course_desc, :course_subject, :course_identifier, :course_type, :course_url, :course_abstract, :course_application_procedure
	def initialize(id)

		client = Savon::Client.new(wsdl: "http://www.hefty.ws/services/GetCourses?wsdl")
		response = client.call(:get_course_by_id, message: { "courseid" => id })
		#client = Savon::Client.new(wsdl: "http://www.webservicex.net/uszip.asmx?WSDL")
    #response = client.request :web, :get_info_by_zip, body: { "USZip" => id }
    #response = client.call(:get_info_by_zip, message: { "USZip" => id })
		if response.success?
    	#data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first
			data = response.to_hash[:catalog]#[:get_info_by_zip_result][:new_data_set][:table]	    
			#provider = response.to_hash[:catalog][:provider]
			courses = response.to_array(:catalog, :provider, :course)
			#doc = response.doc
			if data
				@contributor = data[:contributor]
				@description = data[:description]
				@provider_description = data[:provider][:description]
				@provider_url = data[:provider][:url]
				@provider_identifier = data[:provider][:identifier]
				@provider_title = data[:provider][:title]

				#courses.each do |r|
					unless courses.nil?
						if courses.count > 1
							@course_title = courses[0].to_hash[:title]
						else
							@course_title = data[:provider][:course][:title]
							@course_type = data[:provider][:course][:type]
							@course_identifier = data[:provider][:course][:identifier]
							@course_subject = data[:provider][:course][:subject]
							@course_desc = data[:provider][:course][:description]
							@course_url = data[:provider][:course][:url]
							@course_abstract = data[:provider][:course][:abstract]
							@course_application_procedure = data[:provider][:course][:applicationProcedure]
						end
					end
					
					#doc.css('course').first do |co|
					#	@coursedesc = co.to_hash[:description]
					#end
			end
#	    end
    end

	end
end



