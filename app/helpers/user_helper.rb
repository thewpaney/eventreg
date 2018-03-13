module Events
  class App
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
          result = workshop.canSignUp(user)
          if (result[:result])
            user.workshops << workshop
            user.save!
            if user.role == "student"
              workshop.staken += 1
              workshop.students << user
            elsif user.role == "teacher"
              workshop.ttaken += 1  
              workshop.teachers << user
            end
            workshop.save!
            success << w
            puts "  Signed up for #{workshop.name} ID #{w}" if verbose
            if workshop.twofer_ref != 0
              twin = Workshop.find(workshop.twofer_ref)
              user.workshops << twin
              user.save!
              twin.staken += 1 if user.role == "student"
              twin.ttaken += 1 if user.role == "teacher"
              twin.save!
              success << workshop.twofer_ref
              puts "  Signed up for #{twin.name} ID #{workshop.twofer_ref}" if verbose
              # Check if we were also passed in the twofer workshop ID
              if workshops.include?(workshop.twofer_ref)
                workshops.delete(workshop.twofer_ref)
              end
            end
          else
            puts "Failed signup for #{workshop.name} ID #{w}: #{result[:status]}"# if verbose # Probably should always print this
          end
        end
        return success
      end # sign_up_user

      # @brief Returns an array of teachers with incomplete or malformed registration
      # @return An array of problem teacher IDs
      def problem_teachers
        return User.teachers.all.collect { |t|
          sessions = t.workshops.collect {|w| w.session}
          t.id if
            (t.workshops.count != 3 or \
             t.workshop_ids.select {|w| t.workshop_ids.count(w) > 1}.count > 1 or \
             sessions.select {|s| sessions.count(s) > 1}.uniq != [] or \
             t.workshops.collect {|w| w.tlimit.to_i - w.ttaken.to_i}.delete_if {|v| v > 0} != [])
        }.delete_if {|t| t.nil?}
      end # problem_teachers
      
      # @brief Returns an array of students with incomplete or malformed registration
      # @return An array of problem student IDs
      def problem_students
        return User.students.all.collect { |t|
          sessions = t.workshops.collect {|w| w.session}
          t.id if
            (t.workshops.count != 3 or \
             t.workshop_ids.select {|w| t.workshop_ids.count(w) > 1}.count > 1 or \
             sessions.select {|s| sessions.count(s) > 1}.uniq != [] or \
             t.workshops.collect {|w| w.slimit.to_i - w.staken.to_i}.delete_if {|v| v > 0} != [])
        }.delete_if {|t| t.nil?}
      end # problem_students
      
      # @brief Returns an array of problem workshops
      # @return An array of problem workshop IDs
      def problem_workshops
        # For now: problem workshops exceed gender limits
        return Workshop.all.collect { |w|
          percentage = w.percentage.to_f / 100.to_f
          w.id if
            (percentage < w.girls.count / w.slimit.to_f or \
             percentage < w.boys.count / w.slimit.to_f)
        }.delete_if {|w| w.nil?}
      end # problem_workshops

      # @brief Determine whether registration is complete
      # @return Boolean value
      def registration_complete?
        return (problem_teachers == [] and problem_students == [] and problem_workshops == [])
      end # registration_complete?

      # @brief Place a user in a workshop without checking limits
      # @param user Type Student or Teacher - the user to register
      # @param workshops Type Array - array of workshop IDs to register
      # @param verbose Type Boolean - whether to print logs, defaults to true
      # @return nil
      def force_register(user, workshops, verbose = true)
        workshops.each do |w|
          workshop = Workshop.find(w)
          user.workshops << workshop
          user.save!
          workshop.students << user if user.role == "student"
          workshop.teachers << user if user.role == "teacher"
          workshop.staken += 1 if user.role == "student"
          workshop.ttaken += 1 if user.role == "teacher"
          workshop.save!
        end
        return nil
      end
    end

    helpers UserHelper
  end
end
