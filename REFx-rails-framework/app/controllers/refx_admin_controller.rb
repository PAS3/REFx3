class RefxAdminController < ApplicationController

  def flushlog
	  system('rake log:clear')
	  respond_to do |format|
          format.html { redirect_to(jobs_url) }
          #format.html { redirect_to(root_url) }
		  format.xml  { head :ok }
	  end
  end
end
