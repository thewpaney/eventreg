module UserHelper
  # @brief Sign up a user for an array of workshops
  #
  # Handles twofers robustly
  # 
  # @param user Type Student or Teacher - the user to be registered
  # @param workshops Type Array - array of workshop IDs
  # @param verbose Type Boolean - whether to print logs, defaults to true
  # @return An array of the workshop IDs that were successful
  def sign_up_user(user, workshops, verbose = true)
    success = []
    puts "#{user.full} signing up for IDs #{workshops.inspect}" if verbose
    workshops.each do |w|
      workshop = Workshop.find(w)
      unless (whynot = workshop.cantSignUp user)
        user.workshops << workshop
        workshop.staken += 1 if user.class == Student
        workshop.ttaken += 1 if user.class == Teacher
        workshop.save!
        success << w
        puts "  Signed up for #{workshop.name} ID #{w}" if verbose
        if workshop.twofer_ref != 0
          twin = Workshop.find(workshop.twofer_ref)
          workshops << twin
          twin.staken += 1 if user.class == Student
          twin.ttaken += 1 if user.class == Teacher
          twin.save!
          success << workshop.twofer_ref
          puts "  Signed up for #{twin.name} ID #{workshop.twofer_ref}" if verbose
          # Check if we were also passed in the twofer workshop ID
          if workshops.include?(workshop.twofer_ref)
            workshops.delete(workshop.twofer_ref)
          end
        end
      else
        puts "Failed signup for #{workshop.name} ID #{w}: #{whynot}" if verbose
      end
    end
    return success
  end
end
