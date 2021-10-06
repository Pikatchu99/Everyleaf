require 'rails_helper'
describe 'Fonction de gestion des tâches', type: :system do
  describe "Fonction d'affichage de liste" do
    context "Lors de la transition vers l'écran de liste" do
      it "Une liste des tâches créées s'affiche" do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, name: 'task', details: 'modeste')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
end

describe 'Fonction de gestion des tâches', type: :system do
    describe 'Nouvelle fonction de création' do
      context "Lors de la création d'une nouvelle tâche" do
        it "La tâche créée s'affiche" do
        visit new_task_path
        fill_in "Name",	with: "Belgique"
        fill_in "Details",	with: "Je serai en Belgique cet été."
        click_on 'Create Task'
        expect(page).to have_content 'Je serai en Belgique cet été.'
      end
    end
  end
end

describe 'Fonction de gestion des tâches', type: :system do
  describe 'Nouvelle fonction de création' do
    context "Lors de l'affichage des details d'une tache" do
      it "Je cree et j'obtient les details" do
        task = FactoryBot.create(:task)
        visit tasks_path
        click_on 'Show'
        expect(page).to have_content "I'm description"
      end
    end
  end
end

describe 'Fonction de gestion des tâches', type: :system do
  describe 'Nouvelle fonction de création' do
    context "teste l'affichage" do
      it "Verifier l'odre de classement" do
        task = FactoryBot.create(:task, name: "123", details: "456")
        task2 = FactoryBot.create(:task, name: "3a21", details: "654")
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "3a21"
      end
    end
  end
end

describe 'Fonction de gestion des tâches', type: :system do
  describe 'Nouvelle fonction de création' do
    context "Test de l'affichage en fonction de la deadline" do
      it "Verifier l'odre de classement en fonction de la deadline" do
        task = FactoryBot.create(:task, name: "Paris", details: "Paris c'est tragique", expired_at: DateTime.now + 1.day)
        task2 = FactoryBot.create(:task, name: "France", details: "France c'est bien", expired_at: DateTime.now + 10.day)
        task3 = FactoryBot.create(:task, name: "Tunisie", details: "Tunisie c'est beau", expired_at: DateTime.now - 1.day)
        task4 = FactoryBot.create(:task, name: "Fr", details: "Fr c'est bien", expired_at: DateTime.now + 20.day)
        visit tasks_path do
        click_on "DeadLine"
        task_list = all(".task_row")
        expect(task_list[0]).to have_content "Fr"
        end
      end
    end
  end
end


# Test search by name
describe 'Fonction de gestion des tâches', type: :system do
  describe "Nouvelle fonction d'affichage" do
    context "Test de l'affichage en fonction de la recherche by name" do
      it "Verifier ce qui s'affiche apres une recherche by name" do
        task = FactoryBot.create(:task, name: "Paris", details: "Paris c'est tragique")
        task2 = FactoryBot.create(:task, name: "France", details: "France c'est bien")
        task3 = FactoryBot.create(:task, name: "Tunisie", details: "Tunisie c'est beau")
        task4 = FactoryBot.create(:task, name: "Fr", details: "Fr c'est bien")
        visit tasks_path
        fill_in "search_title", with: "France"
        click_on "search"
        task_list = all(".task_row")
        expect(task_list[0]).to have_content "France"
        expect(task_list.count).to eq 1
      end
    end
    #Test search by status
    context "Test de l'affichage en fonction de la recherche by status" do
      it "Verifier ce qui s'affiche apres une recherche by status" do
        task = FactoryBot.create(:task, name: "Paris", details: "Paris c'est tragique" , status: "Unstarted")
        task2 = FactoryBot.create(:task, name: "France", details: "France c'est bien"  , status: "Unstarted")
        task3 = FactoryBot.create(:task, name: "Tunisie", details: "Tunisie c'est beau", status: "In progress")
        task4 = FactoryBot.create(:task, name: "Fr", details: "Fr c'est bien"          , status: "Completed")
        visit tasks_path
        page.select 'Unstarted', from: 'search_status'
        click_on "search"
        task_list = all(".task_row")
        expect(task_list[0]).to have_content "Paris"
        expect(task_list[1]).to have_content "France"
        expect(task_list.count).to eq 2
      end
    end
    #Test search by status and by name
    context "Test de l'affichage en fonction de la recherche by status & name" do
      it "Verifier ce qui s'affiche apres une recherche  by status & name" do
        task = FactoryBot.create(:task, name: "Paris", details: "Paris c'est tragique" , status: "Unstarted")
        task2 = FactoryBot.create(:task, name: "France", details: "France c'est bien"  , status: "Unstarted")
        task3 = FactoryBot.create(:task, name: "Tunisie", details: "Tunisie c'est beau", status: "In progress")
        task4 = FactoryBot.create(:task, name: "Fr", details: "Fr c'est bien"          , status: "Completed")
        visit tasks_path
        fill_in "search_title", with: "Paris"
        page.select 'Unstarted', from: 'search_status'
        click_on "search"
        task_list = all(".task_row")
        expect(task_list[0]).to have_content "Paris"
        expect(task_list.count).to eq 1
      end
    end
  end
end


describe 'Fonction de gestion des tâches', type: :system do
  describe 'Nouvelle fonction de création' do
    context "Test de l'affichage en fonction de la priorité" do
      it "Verifier l'odre de classement en fonction de la priorité" do
        task = FactoryBot.create(:task, name: "Paris", details: "Paris c'est tragique" , status: "Unstarted"  , priority: "low")
        task2 = FactoryBot.create(:task, name: "France", details: "France c'est bien"  , status: "Unstarted"  , priority: "low")
        task3 = FactoryBot.create(:task, name: "Tunisie", details: "Tunisie c'est beau", status: "In progress", priority: "high")
        task4 = FactoryBot.create(:task, name: "Fr", details: "Fr c'est bien"          , status: "Completed"  , priority: "medium")
        visit tasks_path do
        click_on "Priority"
        task_list = all(".task_row")
        expect(task_list[0]).to have_content "Tunisie"
        expect(task_list[1]).to have_content "Fr"
        end
      end
    end
  end
end
