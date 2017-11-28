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
        expect(page).to have_content("Exercise has not been created")
        exercise = Exercise.last
        expect(page.current_path).to eq(user_exercise_path(@john, exercise))
    end
    
    scenario "with invalid input" do
        visit "/"
        click_link "My Lounge"
        click_link "New Workout"
        expect(page).to have_link("Back")
        fill_in "Duration", with: nil
        fill_in "Workout Details" , with:""
        fill_in "Activity date", with: ""
        click_button "Create Exercise"
        expect(page).to have_content("Exercise has not been created")
        expect(page).to have_content("Duration in min can't be blank")
        expect(page).to have_content("Duration in min is not a number")
        expect(page).to have_content("Workout can't be blank")
        expect(page).to have_content("Workout date can't be blank")
    end
end