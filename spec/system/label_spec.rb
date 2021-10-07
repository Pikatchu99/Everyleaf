require 'rails_helper'
RSpec.describe 'Fonction de gestion des tâches', type: :system do
    before do
    FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session[email]', with: 'test00@gmail.com'
    fill_in 'session[password]', with: '..........'
    click_button "Je me connecte"
    FactoryBot.create(:task)
    FactoryBot.create(:label)
end

describe 'Fonction des tâches', type: :system do
    let!(:task) { FactoryBot.create(:task, name: "title", details: "content1", status: "Unstarted", priority: 'low') }
    before do 
        @task = FactoryBot.create(:task, name: "task", details: "content1")
    end
        context "Search by label" do
            it "Return a list with label search " do
                visit tasks_path
                select "title", from: "search_label"
                click_on "search"
                expect(page).to have_content 'title'
            end
        end
    end
end