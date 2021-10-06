require 'rails_helper'

#Registration
describe "Test d'inscription des utilisateurs", type: :system do
    context "Pouvoir enregistrer de nouveaux utilisateurs" do
        it "Enregistrement du nouvelle utilisateur réussi" do
            visit root_path
            fill_in "Name",	with: "User001"
            fill_in "Email", with: "user001@gmail.com"
            fill_in "Password", with: "......"
            fill_in "Password confirmation", with: "......"
            click_on "Je m'inscris"
            expect(page).to have_content 'Successfully and Already Connected'
            expect(page).to have_content 'User001'
            expect(page).to have_content 'user001@gmail.com'
        end
    end
    context "Accès à la plateforme sans se connecter" do
        it "Non autorisation et redirection vers le login" do
            visit tasks_path
            expect(page).to have_content 'You must be logged in to access this section'
            expect(page).to have_content 'Se Connecter'
        end
    end
end

#Connexion
describe "Test de connexion des utilisateurs", type: :system do
    context "Pouvoir se connecter et accerder a sa My Page" do
        it "Connexion de l'utilisateur réussi" do
            user = FactoryBot.create(:user)
            visit new_session_path
            fill_in "Email", with: "test00@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            expect(page).to have_content 'Login success'
            expect(page).to have_content 'Tasks'
            click_on "My Account"
            expect(page).to have_content 'Account Details'
            expect(page).to have_content 'test00'
        end
    end
    context "Accès aux informations d'un autre user" do
        it "Non autorisation et redirection vers la page des tasks" do
            user = FactoryBot.create(:user)
            visit new_session_path
            fill_in "Email", with: "test00@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            visit user_path(5)
            expect(page).to have_content 'This is not your page'
            expect(page).to have_content 'Tasks'
        end
    end
    context "Boutton de deconnexion" do
        it "Deconnexion et redirection vers la page de login" do
            user = FactoryBot.create(:user)
            visit new_session_path
            fill_in "Email", with: "test00@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Logout"
            expect(page).to have_content 'Deconnecté'
            expect(page).to have_content 'Se Connecter'
        end
    end
end


# Ecran de gestion
describe "Manegement des users pas un admin", type: :system do
    context "Pouvoir accerder l'ecran de management en tant que admin" do
        it "Accès autorisé administrateur" do
            user = FactoryBot.create(:user)
            user1 = FactoryBot.create(:user, email: "popo@gmail.com", name: "popo", password: "..........")
            user2 = FactoryBot.create(:user, email: "popo2@gmail.com", name: "popo2", password: "..........")
            user11 = FactoryBot.create(:user, email: "momo@gmail.com", name: "momo", password: "..........", is_admin: true)
            visit new_session_path
            fill_in "Email", with: "momo@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Management Users"
            expect(page).to have_content 'Users'
            expect(page).to have_content 'popo@gmail.com'
            expect(page).to have_content 'popo2@gmail.com'
        end
    end
    context "Ne pas pouvoir accerder l'ecran de management en tant que user simple" do
        it "Accès non-autorisé user" do
            user = FactoryBot.create(:user)
            user1 = FactoryBot.create(:user, email: "popo@gmail.com", name: "popo", password: "..........")
            user2 = FactoryBot.create(:user, email: "popo2@gmail.com", name: "popo2", password: "..........")
            user11 = FactoryBot.create(:user, email: "momo@gmail.com", name: "momo", password: "..........", is_admin: false)
            visit new_session_path
            fill_in "Email", with: "momo@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Management Users"
            expect(page).to have_content 'Only admin can access'
            expect(page).to have_content 'Tasks'
        end
    end
    context "Admin doit pouvoir creer de nouveaux utilisateurs" do
        it "Creation de l'utilisateur reussi" do
            user11 = FactoryBot.create(:user, email: "momo@gmail.com", name: "momo", password: "..........", is_admin: true)
            visit new_session_path
            fill_in "Email", with: "momo@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Management Users"
            click_on "New User"
            fill_in "Name", with: "user1"
            fill_in "Email", with: "user1@gmail.com"
            fill_in "Password", with: "......"
            click_on "J'inscris un utilisateur"
            expect(page).to have_content "User create successfuly"
            expect(page).to have_content 'user1@gmail.com'
            expect(page).to have_content 'Utilisateur simple'
        end
    end
    context "Admin doit pouvoir acceder a l'ecran de details d'un autre user" do
        it "Acces autorisé pour acceder au info d'un autre user" do
            user11 = FactoryBot.create(:user, email: "momo@gmail.com", name: "momo", password: "..........", is_admin: true)
            visit new_session_path
            fill_in "Email", with: "momo@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Management Users"
            click_on "New User"
            fill_in "Name", with: "user1"
            fill_in "Email", with: "user1@gmail.com"
            fill_in "Password", with: "......"
            click_on "J'inscris un utilisateur"
            expect(page).to have_content "User create successfuly"
            expect(page).to have_content 'user1@gmail.com'
            expect(page).to have_content 'Utilisateur simple'
            click_on "Show"
            expect(page).to have_content 'Account Details'
            expect(page).to have_content 'user1'
            expect(page).to have_content 'user1@gmail.com'
        end
    end
    context "Admin doit pouvoir modifier les details d'un autre user" do
        it "Acces autorisé pour modifier les infos d'un autre user" do
            user11 = FactoryBot.create(:user, email: "momo@gmail.com", name: "momo", password: "..........", is_admin: true)
            visit new_session_path
            fill_in "Email", with: "momo@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Management Users"
            click_on "New User"
            fill_in "Name", with: "user1"
            fill_in "Email", with: "user1@gmail.com"
            fill_in "Password", with: "......"
            click_on "J'inscris un utilisateur"
            expect(page).to have_content "User create successfuly"
            expect(page).to have_content 'user1@gmail.com'
            expect(page).to have_content 'Utilisateur simple'
            click_on "Edit"
            fill_in "Name", with: "user11"
            click_on "Enregistrer"
            expect(page).to have_content 'Profile updated'
            expect(page).to have_content 'user11'
            expect(page).to have_content 'user1@gmail.com'
        end
    end
    context "Admin doit pouvoir supprimer un user" do
        it "Acces autorisé pour supprimer un user" do
            user11 = FactoryBot.create(:user, email: "momo@gmail.com", name: "momo", password: "..........", is_admin: true)
            visit new_session_path
            fill_in "Email", with: "momo@gmail.com"
            fill_in "Password", with: ".........."
            click_on "Je me connecte"
            click_on "Management Users"
            click_on "New User"
            fill_in "Name", with: "user1"
            fill_in "Email", with: "user1@gmail.com"
            fill_in "Password", with: "......"
            click_on "J'inscris un utilisateur"
            expect(page).to have_content "User create successfuly"
            expect(page).to have_content 'user1@gmail.com'
            expect(page).to have_content 'Utilisateur simple'
            click_on "Destroy"
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content 'User deleted'
            expect(page).not_to have_content 'user11'
            expect(page).not_to have_content 'user1@gmail.com'
        end
    end
end

