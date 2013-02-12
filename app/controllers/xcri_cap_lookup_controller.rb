class XcriCapLookupController < ApplicationController
	  def index
			    @xcri_cap = XcriCap.new(params[:xcri_cap]) if params[:xcri_cap].present?
	  end
end
