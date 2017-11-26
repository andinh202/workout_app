require "rails_helper"
RSpec.feature "Creating Exercises" do

    before do
        @john = User.create(email:"John@example.com" , password:"password")
        login_as(@john)
    end
    
    scenario "with valid input " do 
        visit "/"
        click_link "My Lounge"
        click_link "New Workout"
        expect(page).to have_link("Back")
        
        fill_in "Duration", with: 70
        fill_in "Workout Details", with: "Weight lifting"
        fill_in "Activity date", with: "2015-08-07"
        click_button "Create Exercise"
        expect(page).to have_content("Exercises has been created")
        exercise = Exercise.last
        expect(page.current_path).to eq(user_exercise_path(@john, exercise))
        
    end
    

end