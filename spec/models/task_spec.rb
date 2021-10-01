require 'rails_helper'
describe 'Fonction de modele de tache' do
  describe 'Essai de validation' do
    context "Si le titre de la tache est vide" do
      it 'Bloquer sur la validation de title' do
        task = Task.new(name: "", details: "Test d'eche")
        expect(task).not_to be_valid
      end
    end
    context "Si les details de la tache sont vides" do
      it 'Bloquer sur la validation de details' do
        task = Task.new(name: "Titre echec", details: "")
        expect(task).not_to be_valid
      end
    end
    context "Si les details de la tache sont vides" do
      it 'validation reussi' do
        task = Task.new(name: "tre echec", details: "HeyLaba")
        expect(task).to be_valid
      end
    end
  end
end