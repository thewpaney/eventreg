Student.all.each do |s| #Iterate through all of the users

  # If they aren't done (have a first, second, and third (I already checked to
  # make that nobody doesn't have more than three workshops. Nobody does!
  #(I wonder if we should have used LISP)))
  unless s.done?

    # If they don't have multiples of a session
    if s.workshops.collect {|s| s.session} != s.workshops.collect {|s| s.session}.uniq?
      # If they are even more special than the people we goofed
      if s.workshops.map(&:session).sort != [2,3,3]
        #Let us know who they are, what's up with them, and what they want
        puts "Special case - #{s.prefix}: #{s.number} {#{s.workshops.map(&:session)}}"
        s.workshops.each {|w| puts "    #{w.name}: #{w.session}"}
      else

        # If a list of all of the names of the workshops in session 1 that are available to them
        # includes their first choice for session three's name, put them in it. 
        if Workshop.firstsAvailable.map(&:name).include? (old_shop = s.workshops.select {|w| w.session = 3}[0]).name
          new_shop = Workshop.firstsAvailable.select {|w| w.name == s.name}.first
          s.workhops.delete(old_shop)
          s.signup new_shop
          
          # Likewise for the other choice for session three
        elsif Workshop.firstsAvailable.map(&:name).include? (old_shop = s.workshops.select {|w| w.session = 3}[1]).name
          new_shop = Workshop.firstsAvailable.select {|w| w.name == s.name}.first
          s.workhops.delete(old_shop)
          s.signup new_shop

          # If neither, just unregister them from the first session three listed,
          # and give them to the random placer
        else
          s.workshops.delete(s.workshops.select {|w| w.session = 3}[0])
        end
      end
    end

    #No matter what
    # If they don't have a first session
    unless s.has_first?
      # Give them the one with the lowest fullness (amount of people/amount of spots)
      miserable = Workshop.firstsAvailable(s).sort {|w, w2| w.sfullness <=> w2.sfullness}.first
      s.signup miserable
    end

    #rinse
    unless s.has_second?
      miserable = Workshop.secondsAvailable(s).sort {|w, w2| w.sfullness <=> w2.sfullness}.first
      s.signup miserable
    end

    #repeat
    unless s.has_third?
      miserable = Workshop.thirdsAvailable(s).sort {|w, w2| w.sfullness <=> w2.sfullness}.first
      s.signup miserable
    end
  end
end

#Repeat for the Teachers. Literally copied and pasted, with only the workshop.sfullness changed to tfullness
Student.all.each do |s| #Iterate through all of the users

  # If they aren't done (have a first, second, and third (I already checked to
  # make that nobody doesn't have more than three workshops. Nobody does!
  #(I wonder if we should have used LISP)))
  unless s.done?

    # If they don't have multiples of a session
    if s.workshops.collect {|s| s.session} != s.workshops.collect {|s| s.session}.uniq?
      # If they are even more special than the people we goofed
      if s.workshops.map(&:session).sort != [2,3,3]
        #Let us know who they are, what's up with them, and what they want
        puts "Special case - #{s.prefix}: #{s.number} {#{s.workshops.map(&:session)}}"
        s.workshops.each {|w| puts "    #{w.name}: #{w.session}"}
      else

        # If a list of all of the names of the workshops in session 1 that are available to them
        # includes their first choice for session three's name, put them in it. 
        if Workshop.firstsAvailable.map(&:name).include? (old_shop = s.workshops.select {|w| w.session = 3}[0]).name
          new_shop = Workshop.firstsAvailable.select {|w| w.name == s.name}.first
          s.workhops.delete(old_shop)
          s.signup new_shop
          
          # Likewise for the other choice for session three
        elsif Workshop.firstsAvailable.map(&:name).include? (old_shop = s.workshops.select {|w| w.session = 3}[1]).name
          new_shop = Workshop.firstsAvailable.select {|w| w.name == s.name}.first
          s.workhops.delete(old_shop)
          s.signup new_shop

          # If neither, just unregister them from the first session three listed,
          # and give them to the random placer
        else
          s.workshops.delete(s.workshops.select {|w| w.session = 3}[0])
        end
      end
    end

    #No matter what
    # If they don't have a first session
    unless s.has_first?
      # Give them the one with the lowest fullness (amount of people/amount of spots)
      miserable = Workshop.firstsAvailable(s).sort {|w, w2| w.tfullness <=> w2.tfullness}.first
      s.signup miserable
    end

    #rinse
    unless s.has_second?
      miserable = Workshop.secondsAvailable(s).sort {|w, w2| w.tfullness <=> w2.tfullness}.first
      s.signup miserable
    end

    #repeat
    unless s.has_third?
      miserable = Workshop.thirdsAvailable(s).sort {|w, w2| w.tfullness <=> w2.tfullness}.first
      s.signup miserable
    end
  end
end

