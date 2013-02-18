require 'nokogiri'
class XcriCap
	attr_reader :message, :contributor, :description, :provider_description, :provider_url, :provider_identifier, :provider_title, :course_title, :course_desc, :course_subject, :course_identifier, :course_type, :course_url, :course_abstract, :course_application_procedure
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
					if courses.empty?
						@message = "No results returned."	
					else
						if courses.count > 1
							@message = "First of " + courses.count.to_s + " results."
							@course_title = courses[0].to_hash[:title]
							@course_type = courses[0].to_hash[:type]
              @course_identifier = courses[0].to_hash[:identifier]
              @course_subject = courses[0].to_hash[:subject]
              @course_desc = courses[0].to_hash[:description]
              @course_url = courses[0].to_hash[:url]
              @course_abstract = courses[0].to_hash[:abstract]
              @course_application_procedure = courses[0].to_hash[:applicationProcedure]
						else
							@message = "1 result."
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
			end
#		else
#			@message = "No results returned"
		end
					#doc.css('course').first do |co|
					#	@coursedesc = co.to_hash[:description]
					#end
#			end
#	    end
#    end

	end
end



