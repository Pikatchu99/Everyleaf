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